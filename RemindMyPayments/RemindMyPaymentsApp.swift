//
//  RemindMyPaymentsApp.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 13.08.2022.
//

import SwiftUI

@main
struct RemindMyPaymentsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
