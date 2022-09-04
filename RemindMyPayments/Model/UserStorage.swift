//
//  UserStorage.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import Foundation


class UserStorage {
    
    static var defaultCurrency: Currency {
        get {
            let currency = UserDefaults.standard.string(forKey: "baseCurrency") ?? ""
            return Currency(rawValue: currency) ?? .usd
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "baseCurrency")
        }
    }
    
}
