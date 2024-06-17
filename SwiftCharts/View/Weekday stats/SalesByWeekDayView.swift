//
//  SimpleSalesByWeekDayView.swift
//  SwiftCharts
//
//  Created by Daniel on 15/06/24.
//

import SwiftUI
import Charts

struct SalesByWeekDayView: View {
    //States
    @ObservedObject var salesViewModel: SalesViewModel
    
    @State private var individualDaysAreShown: Bool = false
    @State private var medianSalesIsShown: Bool = true
    
    var showBestellerHighlighed: Bool {
        !individualDaysAreShown && !medianSalesIsShown
    }
    
    let formatter = DateFormatter()
    
    
    //Functions
    func weekday(for number: Int) -> String {
        formatter.shortWeekdaySymbols[number - 1]
    }
    
    func longWeekday(for number: Int) -> String {
        formatter.weekdaySymbols[number - 1]
    }
    
    //View
    var body: some View {
        VStack(alignment: .leading) {
            if let highestSellingWeekday = salesViewModel.highestSellingWeekday {
                Text("Your highest selling day of the week is ") +
                Text("\(longWeekday(for: highestSellingWeekday.number))").bold().foregroundColor(.blue) +
                     Text(" with an average of ") +
                Text("\(Int(highestSellingWeekday.sales)) sales per day.").bold()
            }
            
            Chart {
                ForEach(salesViewModel.averageSalesByWeekday, id: \.number) {
                    BarMark(x: .value("Day", weekday(for: $0.number)),
                            y: .value("Sales", $0.sales))
                  //  .foregroundStyle(showBestellerHighlighed && $0.number == salesViewModel.highestSellingWeekday?.number ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2))
                    .foregroundStyle(.gray.opacity(0.2))
                    
                    RectangleMark(x: .value("Day", weekday(for: $0.number)),
                                  y: .value("Sales", $0.sales),
                                  height: 2)
                    .foregroundStyle(.gray)
                }
                
                if individualDaysAreShown {
                    ForEach(salesViewModel.salesByWeekday, id: \.number) { weekdayData in
                        ForEach(weekdayData.sales) { saleData in
                            PointMark(x: .value("day", weekday(for:weekdayData.number)),
                                      y: .value("sales", saleData.quantity))
                            .foregroundStyle(.indigo.opacity(0.25))
                        }
                    }
                }
                
                if medianSalesIsShown {
                    let median = salesViewModel.medianSales
                    RuleMark(
                        y: .value("Median", median)
                    )
                    .foregroundStyle(Color.blue)
                    .lineStyle(StrokeStyle(lineWidth: 3))
                    .annotation(position: .top, alignment: .trailing) {
                        Text("Median: \(String(format: "%.2f", median))")
                            .font(.body.bold())
                            .foregroundStyle(.blue)
                            //.background(Color(.systemBackground))
                    }
                }
            }
            .aspectRatio(1, contentMode: .fit)
         
            Toggle(individualDaysAreShown ? "Show all daily sales" : "Hide daily sales", isOn: $individualDaysAreShown)
            
            Toggle(medianSalesIsShown ? "Show median sales" : "Hide median sales", isOn: $medianSalesIsShown)
            
            Spacer()
        }
        .padding()
    }//VStack
}

#Preview {
    SalesByWeekDayView(salesViewModel: .preview)
}
