//
//  SimpleSalesPerBookCategoryPieChartView.swift
//  SwiftCharts
//
//  Created by Daniel on 16/06/24.
//

import SwiftUI
import Charts

struct SimpleSalesPerBookCategoryPieChartView: View {
    //State
    @ObservedObject var salesViewModel: SalesViewModel
    //View
    var body: some View {
        HStack(spacing: 30) {
            SalesPerBookCategoryHeaderView(selectedChartStyle: .pie,
                                           salesViewModel: salesViewModel)
            
            if #available(macOS 14.0, *) {
                Chart(salesViewModel.totalSalesPerCategory, id: \.category) { data in
                    SectorMark(
                        angle: .value("Sales", data.sales),
                        innerRadius: .ratio(0.618),
                        angularInset: 1.5
                    )
                    .cornerRadius(5.0)
                    .opacity(data.category == salesViewModel.bestSellingCategory?.category ? 1 : 0.3)
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 75)
            }
        }
    }
}


#Preview {
    SimpleSalesPerBookCategoryPieChartView(salesViewModel: .preview)
        .padding()
}
