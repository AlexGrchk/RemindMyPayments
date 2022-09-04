//
//  RemindMyPaymentsApp.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 13.08.2022.
//

import SwiftUI
import ComposableArchitecture

struct AppState: Equatable {
    
}

enum AppAction {
    case pushNotificationsAuth
}

struct AppEnvironment {
    func pushNotificationsAuth() {
        PushNotificationManager.shared.requestAuthorization()
    }
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .pushNotificationsAuth:
        environment.pushNotificationsAuth()
        return .none
    }
}


@main
struct RemindMyPaymentsApp: App {
    
    let store: Store<AppState, AppAction> = .init(initialState: .init(), reducer: appReducer, environment: .init())

    var body: some Scene {
        WindowGroup {
            WithViewStore(self.store) { appStore in
                CalendarScreen(store: .init(initialState: .init(), reducer: calendarReducer, environment: .init()))
                    .onAppear {
                        appStore.send(AppAction.pushNotificationsAuth)
                    }
            }
            
        }
    }
}
