//
//  DetailsBookSalesView.swift
//  SwiftCharts
//
//  Created by Daniel on 15/06/24.
//

import SwiftUI

struct DetailsBookSalesView: View {
    //State
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        
        var id: Self { return self }
    }
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var selectedTimeInterval = TimeInterval.day
    
    //View
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selectedTimeInterval.animation()) {
                ForEach(TimeInterval.allCases) { interval in
                    Text(interval.rawValue)
                }
            } label: {
                Text("Time interval")
            }
            .pickerStyle(.segmented)
            
            Group {
                Text("You sold ") +
                Text("\(salesViewModel.totalSales) books").bold().foregroundColor(Color.accentColor) +
                Text(" in the last 90 days.")
            }.padding(.vertical)
            
            Group{
                switch selectedTimeInterval {
                case .day:
                    DailySalesChartView(salesData: salesViewModel.salesData)
                case .week:
                    WeeklyChartsView(salesViewModel: salesViewModel)
                case .month:
                    MonthlyChartView(salesData: salesViewModel.salesData)
                }
            }//Group
            .aspectRatio(0.8, contentMode: .fit)
            
            Spacer()
        }//VStack
        .padding()
    }
}

#Preview {
    DetailsBookSalesView(salesViewModel: .preview)
}
