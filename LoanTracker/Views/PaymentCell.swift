//
//  PaymentCell.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 4/4/24.
//

import SwiftUI

struct PaymentCell: View {
    // MARK: - PROPERTIES
    let amount: Double
    let date: Date

    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            Text(amount, format: .currency(code: "EUR"))
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - PREVIEW
struct PaymentCell_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCell(amount: 400, date: Date())
    }
}
