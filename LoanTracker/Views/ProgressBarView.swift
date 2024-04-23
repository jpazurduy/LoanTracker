//
//  ProgressBar.swift
//  LoanTracker
//
//  Created by Jorge Azurduy on 4/7/24.
//

import SwiftUI

struct ProgressBarView: View {
    // MARK: - PROPERTIES
    private let progress: Progress
    private let barHeight: CGFloat
    
    init(progress: Progress, barHeight: CGFloat = 20.0) {
        self.progress = progress
        self.barHeight = barHeight
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    Text(progress.leftAmount, format: .currency(code: "EUR"))
                        .font(.caption)
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                    
                }
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: min(CGFloat(progress.value) * geometry.size.width, geometry.size.width),
                               height: geometry.size.height, alignment: .center)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemBlue))
                    
                    Text(progress.paidAmount, format: .currency(code: "EUR"))
                        .font(.caption)
                        .padding(.horizontal)
                    
                    
                }
            }
            .cornerRadius(45.0)
            
        }
        .frame(height: barHeight)
    }
}

// MARK: - PREVIEW
struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(progress: Progress(value: 25.0, leftAmount: 75.0, paidAmount: 35))
    }
}
