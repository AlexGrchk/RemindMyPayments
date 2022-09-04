//
//  PushNotificationManager.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 17.08.2022.
//

import Foundation
import DLLocalNotifications
import UserNotifications



class PushNotificationManager {
    
    static let shared = PushNotificationManager()
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
//    func registerNotifications(for payment: Payment) {
//        self.removePendingNotifications(for: payment) {
//            self.createDayBeforeNotifications(for: payment)
//        }
//    }
    
    func registerNotifications(for payment: Payment) {
        var dateComponents: DateComponents = .init()
        dateComponents.day = Int(payment.paymentDay)
        dateComponents.hour = 12
        dateComponents.minute = 0
        dateComponents.second = 0
        let firstNotification = DLNotification(identifier: self.generateNotificationId(with: payment.id ?? "", components: dateComponents), alertTitle: L10n.dontForgetToPay, alertBody: payment.name ?? "", fromDateComponents: dateComponents, repeatInterval: .monthly)
        let scheduler = DLNotificationScheduler()
        scheduler.scheduleNotification(notification: firstNotification)
        scheduler.scheduleAllNotifications()
    }
    
    
    
    
    func removePendingNotifications(for payment: Payment, completion: (() -> Void)? = nil) {
        userNotificationCenter.getPendingNotificationRequests { notifications in
            let filtered = notifications.filter { $0.identifier.starts(with: payment.id ?? "No id for payment") }
                .map { $0.identifier }
            self.userNotificationCenter.removePendingNotificationRequests(withIdentifiers: filtered)
            completion?()
        }
    }
    
    private func addNotificationRequest(with payment: Payment, dateComponents: DateComponents, isRepeated: Bool = false) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = L10n.dontForgetToPay
        notificationContent.body = "\(L10n.tomorrow): \(payment.name ?? "")"
        notificationContent.badge = NSNumber(value: 1)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isRepeated)
        
        let notificationIdentifier = self.generateNotificationId(with: payment.id ?? "", components: dateComponents)
        
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: trigger)
        userNotificationCenter.add(request) { error in
            guard let error = error else {
                return
            }
            print("Error while registering notification request: \(error)")
        }
    }
    
    private func createDayBeforeNotifications(for payment: Payment) {
        let now = Calendar.currentDateInTimeZone
        let components = Calendar.current.dateComponents([.year, .month, .day], from: now)
        
        for year in components.year! ..< (components.year! + 13) {
            for month in 1..<13 {
                var notificationComponents = DateComponents()
                notificationComponents.year = self.getNotificationYear(by: components.day!, paymentMonth: month, paymentYear: year)
                notificationComponents.month = self.getNotificationMonth(by: components.day!, paymentMonth: month, paymentYear: year)
                notificationComponents.day = self.getNotificationDay(by: components.day!, paymentMonth: month, paymentYear: year)
                
                notificationComponents.hour = 10
                notificationComponents.minute = 5
                
                self.addNotificationRequest(with: payment, dateComponents: notificationComponents)
            }
        }
    }
    
    private func getNotificationYear(by paymentDay: Int, paymentMonth: Int, paymentYear: Int) -> Int {
        if paymentMonth == 1 && paymentDay == 1 {
            return paymentYear - 1
        } else {
            return paymentYear
        }
    }

    private func getNotificationMonth(by paymentDay: Int, paymentMonth: Int, paymentYear: Int) -> Int {
        if paymentDay == 1 {
            if paymentMonth == 1 {
                return 12
            } else {
                return paymentMonth - 1
            }
        } else {
            return paymentMonth
        }
    }
    
    private func getNotificationDay(by paymentDay: Int, paymentMonth: Int, paymentYear: Int) -> Int {
        
        if paymentDay == 31 {
            switch paymentMonth {
            case 1, 3, 5, 7, 8, 10, 12:
                return 30
            case 4, 6, 9, 11:
                return 29
            case 2:
                return self.isLeap(year: paymentYear) ? 28 : 27
            default:
                break
            }
        }
        
        if paymentDay == 1 {
            let month = paymentMonth == 1 ? 12 : (paymentMonth - 1)
            switch month {
            case 1, 3, 5, 7, 8, 10, 12:
                return 31
            case 4, 6, 9, 11:
                return 30
            case 2:
                return self.isLeap(year: paymentYear) ? 29 : 28
            default:
                break
            }
        }
        
        
        return paymentDay - 1
    }
    
    private func isLeap(year: Int) -> Bool {
        if year % 4 == 0 {
            if year % 100 == 0 && year % 400 != 0 {
                return false
            } else {
                return true
            }
        } else {
            print(year, terminator: "-")
            return false
        }
    }
    
    private func generateNotificationId(with paymentId: String, components: DateComponents) -> String {
        return "\(paymentId)-.-\(components.year?.description ?? "")-\(components.month?.description ?? "")-\(components.day?.description ?? "")"
    }
    
    
    func requestAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
}
