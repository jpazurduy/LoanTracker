//
//  PaymentView.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 4/3/24.
//

import SwiftUI

struct AddPaymentView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = AddPaymentViewModel()
    
    var loan: Loan
    var payment: Payment?
    
    // MARK: - FUNCTIONS
    
    @ViewBuilder
    private func saveButton() -> some View {
        Button(action: {
            viewModel.savePayment()
            dismiss()
        }, label: {
            Text("Save")
                .font(.subheadline)
                .fontWeight(.semibold)
        })
        //.disabled(viewModel.isInvalidForm())
    }
    
    // MARK: - BODY
    var body: some View {
        Form {
            TextField("Amount", text: $viewModel.amount)
                .keyboardType(.decimalPad)
            
            DatePicker("Date", selection: $viewModel.date, in: Date()..., displayedComponents: .date)
            
        }
        .navigationTitle(payment != nil ? "Edit Payment" : "Add Payment")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                saveButton()
            }
        }
        .onAppear() {
            viewModel.setLoan(loan: loan)
            viewModel.setPayment(payment: payment)
            viewModel.setupEditView()
        }
    }
}

// MARK: - PREVIEW
//struct PaymentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            AddPaymentView(loan: )
//        }
//        
//    }
//}
