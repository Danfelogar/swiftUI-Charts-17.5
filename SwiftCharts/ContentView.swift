//
//  ContentView.swift
//  SwiftCharts
//
//  Created by Daniel on 15/06/24.
//

import SwiftUI

struct ContentView: View {
    //States
    @StateObject var salesViewModel = SalesViewModel.preview
    @StateObject var expensesViewModel: ExpenseViewModel = .preview

    //View
    var body: some View {
        NavigationStack {
            List {
                
                Section{
                    NavigationLink {
                        DetailsBookSalesView(salesViewModel: salesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleBookSalesView(salesViewModel: salesViewModel)
                    }
                }
                
                Section{
                    NavigationLink {
                        SalesByWeekDayView(salesViewModel: salesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleSalesByWeekdayView(salesViewModel: salesViewModel)
                    }
                }
                
                Section {
                    NavigationLink {
                        SalesPerBookCategoryView(salesViewModel: salesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        
                        SimpleSalesPerBookCategoryPieChartView(salesViewModel: salesViewModel)
                    }
                }
                
                Section {
                    NavigationLink {
                        DetailExpensesView(expensesViewModel: expensesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleExpensesLineChartView(expensesViewModel: expensesViewModel)
                    }
                }
            }//List
            .navigationTitle("Your Book Store Stats")
        }//NavigationStack
    }
}

#Preview {
    ContentView()
}
