//
//  LoanTrackerApp.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 3/19/24.
//

import SwiftUI

@main
struct LoanTrackerApp: App {
    
    init() {
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
    }
    
    var body: some Scene {
        WindowGroup {
            AllLoansView()
                .environment(\.managedObjectContext,PersistenceController.shared.container.viewContext)
        }
    }
}
