//
//  SimpleBookSalesView.swift
//  SwiftCharts
//
//  Created by Daniel on 15/06/24.
//

import SwiftUI

struct SimpleBookSalesView: View {
    //States
    @ObservedObject var salesViewModel: SalesViewModel
    
    
    var percentage: Double {
        Double(salesViewModel.totalSales) / Double(salesViewModel.lastTotalSales) - 1
    }
    
    var isPositiveChange: Bool {
        percentage > 0
    }
    
    //Functions
    
    func changedBookSales() -> String? {
        let percentage = percentage
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        let changedDescription = percentage < 0 ? "decreased by " : "increased by "
        
        return changedDescription + formattedPercentage
    }
    
    //View
    var body: some View {
        VStack {
            if let changedBookSales = changedBookSales() {
                HStack {
                    Image(systemName: isPositiveChange ? "arrow.up.right" : "arrow.down.right").bold()
                        .foregroundColor( isPositiveChange ? .green : .red)
    
                    Text("Your book sales ") + Text(changedBookSales).bold() + Text(" in the last 90 days.")
                }//HStack
            }
            
            WeeklyChartsView(salesViewModel: salesViewModel)
                .frame(height: 100)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
        }//VStack
    }
}

#Preview {
    SimpleBookSalesView(salesViewModel: .preview)
        .padding()
}

#Preview("Negative") {
    
    let decreasedVM  = SalesViewModel.preview
    decreasedVM.lastTotalSales = 1000
    
    return SimpleBookSalesView(salesViewModel: decreasedVM)
        .padding()
}
