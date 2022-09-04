//
//  SettingsStore.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 16.08.2022.
//

import Foundation
import ComposableArchitecture



struct SettingsState: Equatable {
    var defaultCurrency: Currency = .usd
}


enum SettingsAction {
    case loadDefaultCurrency
    case saveDefaultCurrency(Currency)
}


struct SettingsEnvironment {
    
}


let settingsReducer = Reducer<SettingsState, SettingsAction, SettingsEnvironment> { state, action, environment in
    switch action {
    case .saveDefaultCurrency(let currency):
        UserStorage.defaultCurrency = currency
        state.defaultCurrency = currency
        return .none
    case .loadDefaultCurrency:
        state.defaultCurrency = UserStorage.defaultCurrency
        return .none
    }
}
