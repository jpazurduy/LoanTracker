//
//  AddLoanViewModel.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 3/20/24.
//

import Foundation

class AddLoanViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var amount: String = ""
    @Published var startDate: Date = Date()
    @Published var dueDate: Date = Date()
    
    func isInvalidForm() -> Bool {
        name.isEmpty || amount.isEmpty
    }
    
    func saveLoan() {
        let loan  = Loan(context: PersistenceController.shared.viewContext)
        
        loan.id = UUID().uuidString
        loan.name = name
        loan.totalAmount = Double(amount) ?? 0.0
        loan.startDate = startDate
        loan.dueDate = dueDate
        
        PersistenceController.shared.save()
    }
}
