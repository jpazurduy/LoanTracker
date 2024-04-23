//
//  PaymentsView.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 3/20/24.
//

import SwiftUI

struct PaymentsView: View {
    // MARK: - PROPERTIES
    @State var isAddLoanShowing = false
    @StateObject private var viewModel = PaymentViewModel()
    
    var loan: Loan
    
    // MARK: - FUCNTIONS
    @ViewBuilder
    private func addButton() -> some View {
        NavigationLink(value: Destination.addPayment(loan)) { 
            Image(systemName: "plus.circle")
                .font(.title3)
                .padding([.vertical, .leading], 5)
        }
    }
    
    @ViewBuilder
    private func progressView() -> some View {
        VStack {
            Text("Payment progress")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top)
            
            
            ProgressBarView(progress: viewModel.progress)
                .padding(.horizontal)
            
            Text(viewModel.expectedToFinishOn)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top)
        }
    }
    
    
    // MARK: - BODY
    var body: some View {
        VStack {
            progressView()
            
            List {
                
                ForEach(viewModel.allPaymentsObjects, id: \.sectionName) { paymentObject in
                    Section {
                        ForEach(paymentObject.sortedSectionObjects) { payment in
                            NavigationLink(value: Destination.addPayment(loan, payment)) {
                                PaymentCell(amount: payment.amount, date: payment.wrappedDate)
                            }
                        }
                        .onDelete { indexSet in
                            withAnimation {
                                viewModel.deleteItems(paymentObjet: paymentObject, index: indexSet)
                            }
                        }
                    } header: {
                        Text("\(paymentObject.sectionName) - \(paymentObject.sectionTotal, format: .currency(code: "EUR"))")
                    }
                }
                
            }
            .listStyle(.grouped)
        }
        .navigationTitle(loan.wrappedName.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton()
            }
        })
        .onAppear() {
            viewModel.setLoan(loan: loan)
            viewModel.calculateProgress()
            viewModel.calculateDays()
            viewModel.separateByYear()
        }
    }
}

// MARK: - PREVIEW
//struct PaymentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            PaymentsView()
//        }
//        
//    }
//}
