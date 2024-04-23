//
//  Payment+CoreDataClass.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 3/20/24.
//
//

import Foundation
import CoreData

@objc(Payment)
public class Payment: NSManagedObject, Comparable {
    public static func < (lhs: Payment, rhs: Payment) -> Bool {
        return lhs.amount < rhs.amount
    }
    

}
