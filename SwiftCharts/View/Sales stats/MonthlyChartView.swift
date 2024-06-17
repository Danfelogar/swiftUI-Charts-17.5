//
//  MonthlyChartView.swift
//  SwiftCharts
//
//  Created by Daniel on 15/06/24.
//

import SwiftUI
import Charts

struct MonthlyChartView: View {
    //States
    let salesData: [Sale]
    
    //View
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Month", sale.saleDate, unit: .month),
                    y: .value("Sales", sale.quantity))
            //            .foregroundStyle(Color.blue.gradient)
            
        }//Chart
        .chartXAxis{
            AxisMarks { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
            }
        }
        .chartYAxis{
            AxisMarks(position: .leading) { _ in
                AxisTick()
                AxisValueLabel()
            }
        }
        
    }
}

#Preview {
    MonthlyChartView(salesData: Sale.threeMonthsExamples())
        .aspectRatio(1 ,contentMode: .fit)
        .padding()
}
