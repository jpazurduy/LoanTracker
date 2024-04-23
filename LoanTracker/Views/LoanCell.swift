//
//  LoanCell.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 3/20/24.
//

import SwiftUI

struct LoanCell: View {
    // MARK: - PROPERTIES
    let name: String
    let amount: Double
    let date: Date
    
    // MARK: - BODY
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(amount, format: .currency(code: "EUR"))
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
}

// MARK: - PREVIEW
struct LoanCell_Previews: PreviewProvider {
    static var previews: some View {
        LoanCell(name: "", amount: 0.0, date: Date())
    }
}
