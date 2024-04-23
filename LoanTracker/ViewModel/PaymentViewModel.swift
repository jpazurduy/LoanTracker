//
//  PaymentViewModel.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 4/4/24.
//

import Foundation

final class PaymentViewModel: ObservableObject {
    @Published private(set) var expectedToFinishOn = ""
    @Published private(set) var progress = Progress()
    @Published private(set) var allPayments: [Payment] = []
    @Published private(set) var allPaymentsObjects: [PaymentSection] = []
    
    private(set) var loan: Loan?
    
    func setLoan(loan: Loan) {
        self.loan = loan
        setPayments()
    }
    
    func setPayments() {
        guard let loan = loan else { return }
        allPayments = loan.paymentsArray
        allPayments.sort()
    }
    
    func calculateProgress() {
        guard let loan = loan else { return }
        
        let totalPaid = allPayments.reduce(0) { $0 + $1.amount }
        
        let totalLeft = loan.totalAmount - totalPaid
        
        let value = totalPaid / loan.totalAmount
        
        progress = Progress(value: value, leftAmount: totalLeft, paidAmount: totalPaid)
    }
    
    func calculateDays() {
        guard let loan = loan else { return }
        let totalPaid = allPayments.reduce(0) { $0 + $1.amount }
        
        let totalDays = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: loan.wrappedDueDate).day!
        
        let passedDays = Calendar.init(identifier: .gregorian).numberOfDaysBetween(from: loan.wrappedStartDate, and: Date())
        
        if passedDays == 0 || totalPaid == 0 {
            expectedToFinishOn = ""
            return
        }
        
        let didPaidPerDay = totalPaid / Double(passedDays)
        
        let shouldPayPerDay = loan.totalAmount / Double(totalDays)
        
        if shouldPayPerDay < didPaidPerDay {
            
        } else {
            
        }
        
        let daysLeftToFinish = (loan.totalAmount - totalPaid) / didPaidPerDay
        
        let newDate = Calendar.current.date(byAdding: .day, value: Int(daysLeftToFinish), to: Date())
        
        guard let newDate = newDate else {
            expectedToFinishOn = ""
            return
        }
        
        expectedToFinishOn = "Expected to finish by \(newDate.formatted(date: .long, time: .omitted))"
    }
        
    
    func separateByYear() {
        allPaymentsObjects = []
        
        let dict = Dictionary(grouping: allPayments, by: {$0.wrappedDate.intOfYear })
        
        for (key, value) in dict {
            guard let key = key else { return }
            
            let total = value.reduce(0) { $0 + $1.amount}
            
            allPaymentsObjects.append(PaymentSection(sectionName: "\(key)",
                                                     sectionObjects: value.reversed(),
                                                     sectionTotal: total ))
        }
        
        allPaymentsObjects.sort(by: {$0.sectionName > $1.sectionName})
        
        
    }
    
    func deleteItems(paymentObjet: PaymentSection, index: IndexSet) {
        guard let deleteIndex = index.first else { return }
        
        let paymentToDelete = paymentObjet.sectionObjects[deleteIndex]
        
        PersistenceController.shared.viewContext.delete(paymentToDelete)
        PersistenceController.shared.save()
        
        setPayments()
        calculateProgress()
        calculateDays()
        separateByYear()
    }
}
