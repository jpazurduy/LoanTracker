//
//  ContentView.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 3/19/24.
//

import SwiftUI
import CoreData

struct AllLoansView: View {
    @Environment(\.managedObjectContext) var context
    
    @State var isAddLoanShowing: Bool = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)], animation: .default)
    private var loans: FetchedResults<Loan>
    
    @State var navigationPath = NavigationPath()
    
    @ViewBuilder
    private func addButton() -> some View {
        Button {
            isAddLoanShowing = true
        } label: {
            Image(systemName: "plus.circle")
                .font(.title3)
        }
        .padding([.vertical, .leading], 5)

    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(loans) { loan in
                    NavigationLink(value: Destination.payment(loan)) {
                        LoanCell(name: loan.wrappedName.capitalized, amount: loan.totalAmount, date: loan.wrappedStartDate)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .navigationTitle("All Loans")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton()
                }
            })
            .sheet(isPresented: $isAddLoanShowing) {
                AddLoanView()
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                    case .payment(let loan):
                        PaymentsView(loan: loan)
                    case .addPayment(let loan, let payment):
                        AddPaymentView(loan: loan, payment: payment)
                }
                
                
            }
        }
    }
    
    func deleteItems(offset: IndexSet) {
        withAnimation {
            offset.map { loans[$0] }.forEach(context.delete)
            PersistenceController.shared.save()
        }
    }
}

#Preview {
    AllLoansView()
}
