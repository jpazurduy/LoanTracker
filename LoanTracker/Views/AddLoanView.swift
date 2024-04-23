//
//  AddLoanView.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 3/19/24.
//

import SwiftUI

struct AddLoanView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: AddLoanViewModel = AddLoanViewModel()
    
    // MARK: - FUCNTIONS
    
    @ViewBuilder
    private func cancelButton() -> some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
    
    @ViewBuilder
    private func saveButton() -> some View {
        Button(action: {
            viewModel.saveLoan()
            dismiss()
        }, label: {
            Text("Save")
                .font(.subheadline)
                .fontWeight(.semibold)
        })
        .disabled(viewModel.isInvalidForm())
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Name", text: $viewModel.name)
                        .autocapitalization(.sentences)
                    TextField("Amount", text: $viewModel.amount)
                        .keyboardType(.decimalPad)
                    
                    DatePicker("Start Date", selection: $viewModel.startDate, in: ...Date(), displayedComponents: .date)
                    
                    DatePicker("Due Date", selection: $viewModel.dueDate, in: viewModel.startDate..., displayedComponents: .date)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton()
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    saveButton()
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct AddLoanView_Previews: PreviewProvider {
    static var previews: some View {
        AddLoanView()
    }
}
