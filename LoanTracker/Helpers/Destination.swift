//
//  Destination.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 4/3/24.
//

import Foundation

enum Destination: Hashable {
    case payment(Loan)
    case addPayment(Loan, Payment? = nil)
}
