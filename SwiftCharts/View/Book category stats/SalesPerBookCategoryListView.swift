//
//  SalesPerBookCategoryListView.swift
//  SwiftCharts
//
//  Created by Daniel on 16/06/24.
//

import SwiftUI

struct SalesPerBookCategoryListView: View {
    //States
    @ObservedObject var salesViewModel: SalesViewModel

    //View
    var body: some View {
        List{
            ForEach(salesViewModel.totalSalesPerCategory, id: \.category) { data in
                Section {
                    ForEach(salesViewModel.findBooks(for: data.category)) { book in
                        Text(book.title)
                            .badge(salesViewModel.sales(for: book))
                    }
                } header: {
                    HStack{
//                        Text("\(data.category.rawValue)")
                        Text("\(data.sales)")
                    }
                }
            }
        }
    }
}


#Preview {
    SalesPerBookCategoryListView(salesViewModel: .preview)
}
