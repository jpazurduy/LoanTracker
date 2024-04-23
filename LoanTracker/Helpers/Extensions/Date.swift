//
//  Date.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 4/21/24.
//

import Foundation

extension Date {
    
    var intOfYear: Int? {
        Calendar.current.dateComponents([.year], from: self).year
    }
}
