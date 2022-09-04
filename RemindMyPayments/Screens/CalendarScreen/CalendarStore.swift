//
//  CalendarStore.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 13.08.2022.
//

import Foundation
import ComposableArchitecture


struct CalendarState: Equatable {
    var payments: [Payment] = []
    
    var selectedDetailsPayment: Payment?
    var selectedEditPayment: Payment?
    var selectedCalendarDate: Date?
    var showSettings: Bool = false
    var showNewPayment: Bool = false
    var updated: Bool = false
    
    
    func hasPayment(on date: Date) -> Bool {
        
        if date.isLastDayOfMonth {
            return payments.first(where: { $0.paymentDay == 31 }) != nil
        }
        return payments.first(where: { $0.paymentDay == date.day }) != nil
    }
    
    func payments(on date: Date) -> [Payment] {
        if date.isLastDayOfMonth {
            return self.payments.filter { $0.paymentDay == 31 }
        }
        return self.payments.filter { $0.paymentDay == date.day }
    }
    
}


enum CalendarAction: Equatable {
    
    case loadPayments
    case toggleAddNew
    case toggleSettings
    case editPayment(index: Int)
    case removePayment(index: Int)
    case viewDetails(index: Int)
    case markPayment(index: Int)
    case calendarDateSelected(Date?)
    case closeAddNew
}

struct CalendarEnvironment {
    
    func removeNotifications(for payment: Payment, completion: @escaping () -> Void) {
        PushNotificationManager.shared.removePendingNotifications(for: payment, completion: completion)
    }
    
}


let calendarReducer = Reducer<CalendarState, CalendarAction, CalendarEnvironment> { state, action, environment in
    switch action {
    case .loadPayments:
        state.payments = PersistenceClient.getAllActivePayments()
        return .none
    case .toggleAddNew:
        state.showNewPayment.toggle()
        return .none
    case .toggleSettings:
        state.showSettings.toggle()
        return .none
    case .editPayment(index: let index):
        state.selectedEditPayment = state.payments[safe: index]
        return .none
    case .removePayment(index: let index):
        guard let payment = state.payments[safe: index] else {
            return .none
        }
        environment.removeNotifications(for: payment) {
            PersistenceClient.delete(payment: payment)
        }
        state.payments.remove(at: index)
        return .none
    case .viewDetails(index: let index):
        state.selectedDetailsPayment = state.payments[safe: index]
        return .none
    case .markPayment(index: let index):
        guard let payment = state.payments[safe: index] else {
            return .none
        }
        let payments = PersistenceClient.markPayment(payment: payment)
        state.payments = payments
        state.updated.toggle()
        return .none
    case .calendarDateSelected(let date):
        state.selectedCalendarDate = date
        return .none
    case .closeAddNew:
        state.showNewPayment = false
        state.selectedEditPayment = nil
        return .none
    }
}
