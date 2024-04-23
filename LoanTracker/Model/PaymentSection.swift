//
//  PaymentSection.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 4/19/24.
//

import Foundation

struct PaymentSection: Equatable {
    var sectionName: String
    var sectionObjects: [Payment]
    var sectionTotal: Double
    
    var sortedSectionObjects: [Payment] {
        sectionObjects.sorted { $0.date ?? Date() > $1.date ?? Date() }
    }
}
