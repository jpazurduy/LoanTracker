//
//  AddPaymentViewModel.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 4/3/24.
//

import Foundation

class AddPaymentViewModel: ObservableObject {
    
    
    @Published var amount = ""
    @Published var date: Date = Date()
    
    private var loan: Loan?
    private var payment: Payment?
    
    func isInvalidForm() -> Bool {
        amount.isEmpty
    }
    
    func setLoan(loan: Loan) {
        self.loan = loan
    }
    
    func setPayment(payment: Payment?) {
        self.payment = payment
    }
    
    func savePayment() {
        payment != nil ? updatePayment() : createNewPayment()
    }
    
    private func createNewPayment() {
        let payment  = Payment(context: PersistenceController.shared.viewContext)
        
        payment.id = UUID().uuidString
        payment.amount = Double(amount) ?? 0.0
        payment.date = date
        payment.loan = loan
        
        PersistenceController.shared.save()
    }
    
    private func updatePayment() {
        guard let payment = payment else { return }
        
        payment.amount = Double(amount) ?? 0.0
        payment.date = date
        
        PersistenceController.shared.save()
    }
    
    func setupEditView() {
        guard let payment = payment else { return }
        
        amount = "\(payment.amount)"
        date = payment.wrappedDate
    }
}

