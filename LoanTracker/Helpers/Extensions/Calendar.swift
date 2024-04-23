//
//  Calendar.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 4/22/24.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}
