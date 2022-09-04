//
//  Persistence.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 13.08.2022.
//

import CoreData
import ComposableArchitecture

class PersistenceClient {
    
    static var shared: PersistenceClient = .init()
    public struct Failure: Error, Equatable {}
    
    
    func saveContext() {
        do {
            try self.container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "RemindMyPayments")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
}


// MARK: -- Payment persistance
extension PersistenceClient {
    static func getAllActivePayments() -> [Payment] {
        let request = Payment.fetchRequest()
        let query = NSPredicate(format: "wasDeleted = NO")
        request.predicate = query
        do {
            let payments = try self.shared.container.viewContext.fetch(request)
            return payments
        } catch {
            print("Error while requesting active payments: \(error)")
            return []
        }
    }
    
    static func delete(payment: Payment) {
        self.shared.container.viewContext.delete(payment)
        self.shared.saveContext()
    }
    
    static func findPaymentById(id: String, searchDeleted: Bool) {
        
    }
    
    static func createDummyPayment() {
        let payment = Payment(context: self.shared.container.viewContext)
        payment.id = UUID().uuidString
        payment.name = "Name1"
        payment.currency = "USD"
        payment.amount = 1000
        payment.bankAccountName = "Bank Account name"
        payment.dateCreated = Date()
        payment.paymentDay = 14
        self.shared.saveContext()
    }
    
    static func rollBack() {
        self.shared.container.viewContext.rollback()
    }
    
    static func markPayment(payment: Payment) -> [Payment] {
        if payment.isPayedThisMonth,
           let status = payment.currentMonthStatus {
            payment.removeFromStatuses(status)
            self.remove(status: status)
        } else {
            let status = PaymentStatus(context: self.shared.container.viewContext)
            status.id = UUID().uuidString
            status.paymentDate = Calendar.currentDateInTimeZone
            payment.addToStatuses(status)
            self.shared.saveContext()
        }
        let payments = self.getAllActivePayments()
        return payments
    }
    
    static func createEmptyPayment() -> Payment {
        let payment = Payment(context: self.shared.container.viewContext)
        payment.dateCreated = Calendar.currentDateInTimeZone
        payment.id = UUID().uuidString
        payment.currency = UserStorage.defaultCurrency.rawValue
        return payment
    }
    
}


// MARK: -- PaymentStatus persistance
extension PersistenceClient {
    
    static func remove(status: PaymentStatus) {
        self.shared.container.viewContext.delete(status)
        self.shared.saveContext()
    }
    
}
