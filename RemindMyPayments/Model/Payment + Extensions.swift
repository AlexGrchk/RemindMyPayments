//
//  Payment + Extensions.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 13.08.2022.
//

import Foundation


extension Payment {
    
    var amountStr: String {
        return String(format: "%.2f", Float(self.amount / 100))
    }
    
    
    var amountCurrency: String {
        return "\(self.amountStr) \(self.currency ?? "")"
    }
    
    var isPayedThisMonth: Bool {
        return self.statuses?.allObjects.map { $0 as! PaymentStatus }.first(where: { $0.paymentDate?.isCurrentMonth() ?? false }) != nil
    }
    
    var currentMonthStatus: PaymentStatus? {
        return self.statuses?.allObjects.map { $0 as! PaymentStatus }.first(where: { $0.paymentDate?.isCurrentMonth() ?? false })
    }
    
    var daysToPaymentStr: String {
        let today = Calendar.currentDateInTimeZone.day
        let dif = today - Int(self.paymentDay)
        if dif == 1 {
            return "\(abs(dif)) \(L10n.day) \(L10n.left)"
        } else if dif == -1 {
            return "\(abs(dif)) \(L10n.day) \(L10n.ago)"
        } else if dif == 0 {
            return L10n.today
        } else if dif > 0 {
            return "\(abs(dif)) \(L10n.days) \(L10n.ago)"
        } else {
            return "\(abs(dif)) \(L10n.days) \(L10n.left)"
        }
    }
    
    func isPayment(on date: Date) -> Bool {
        return self.paymentDay == date.day
    }
    
    var currencyObj: Currency {
        return Currency(rawValue: self.currency ?? "") ?? .usd
    }
    
}
