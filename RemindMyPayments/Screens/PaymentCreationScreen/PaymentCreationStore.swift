//
//  PaymentCreationStore.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import Foundation
import ComposableArchitecture


struct PaymentCreationState: Equatable, Identifiable {
    
    var id: String {
        return payment.id ?? ""
    }
    
    var payment: Payment
    
    var amount: Int64 = 0
    
    var dateTypes: [DateType] = [.firstDayOfMonth, .lastDayOfMonth, .custom]
    var selectedDateType: DateType = .unknown
    
    var isNew: Bool = true
    var updated: Bool = false
    
    init(payment: Payment, isNew: Bool = true) {
        self.payment = payment
        self.isNew = isNew
        if !isNew {
            if payment.paymentDay == 1 {
                self.selectedDateType = .firstDayOfMonth
            } else if payment.paymentDay == 31 {
                self.selectedDateType = .lastDayOfMonth
            } else {
                self.selectedDateType = .custom
            }
        }
    }
    
    enum DateType: String, CaseIterable, DropDownValue {
        
        case firstDayOfMonth
        case lastDayOfMonth
        case custom
        case unknown
        
        var title: String {
            switch self {
            case .firstDayOfMonth:
                return L10n.firstDayOfMonth
            case .lastDayOfMonth:
                return L10n.lastDayOfMonth
            case .custom:
                return L10n.custom
            case .unknown:
                return ""
            }
        }
        
        var dropDownValue: String {
            return self.title
        }
    }
    
}

enum PaymentCreationAction: Equatable {
    case changeName(String)
    case changeAmount(String)
    case changeCurrency(Currency)
    case changeBankAccountName(String)
    case changePaymentDay(Int)
    case dateTypeSelected(PaymentCreationState.DateType)
    case update
    case done
    case dismissing
}

struct PaymentCreationEnvironment {
    var onDone: () -> Void
    
    
    func registerNotifications(for payment: Payment) {
        PushNotificationManager.shared.registerNotifications(for: payment)
    }
    
}


let paymentCreationReducer = Reducer<PaymentCreationState, PaymentCreationAction, PaymentCreationEnvironment> { state, action, environment in
    switch action {
    case .changeName(let name):
        state.payment.name = name
        state.updated.toggle()
        return .none
    case .changeAmount(let amount):
        state.amount = Int64((Float(amount) ?? 0) * 100)
        return .none
    case .changeCurrency(let currency):
        state.payment.currency = currency.rawValue
        state.updated.toggle()
        return .none
    case .changeBankAccountName(let bankAccountName):
        state.payment.bankAccountName = bankAccountName
        state.updated.toggle()
        return .none
    case .changePaymentDay(let paymentDay):
        state.payment.paymentDay = Int16(paymentDay)
        return .none
    case .done:
        state.payment.amount = state.amount
        if case .lastDayOfMonth = state.selectedDateType {
            state.payment.paymentDay = 31
        }
        PersistenceClient.shared.saveContext()
        environment.registerNotifications(for: state.payment)
        return .none
    case .dateTypeSelected(let dateType):
        state.selectedDateType = dateType
        return .none
    case .update:
        state.updated.toggle()
        return .none
    case .dismissing:
        PersistenceClient.rollBack()
        environment.onDone()
        return .none
    }
}
