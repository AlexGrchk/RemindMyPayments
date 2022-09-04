//
//  Date + Extensions.swift
//  RemindMyPayments
//
//  Created by Oleksandr on 13.08.2022.
//

import Foundation


extension Calendar {
    
    static var currentDateInTimeZone: Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
}


extension Date {
    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isSameDay(_ date: Date) -> Bool {
        return Calendar.current.isDate(date, inSameDayAs: self)
    }
    
    func isCurrentMonth() -> Bool {
        let currentDate = Calendar.currentDateInTimeZone
        return currentDate.isEqual(to: self, toGranularity: .month)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    var isLastDayOfMonth: Bool {
        let lastDay = Calendar.currentDateInTimeZone.endOfMonth()
        return lastDay.day == self.day
    }
    
}


