//
//  BookCategory.swift
//  SwiftCharts
//
//  Created by Daniel on 15/06/24.
//

import Foundation

enum BookCategory: Identifiable, CaseIterable {
    case fiction
    case biography
    case children
    case computerScience
    case fantasy
    case business
    
    var id: Self { return self }
    
    var displayName: String {
        switch self {
        case .fiction:
            "Fiction"
        case .biography:
            "Biography"
        case .children:
            "Children"
        case .computerScience:
            "ComputerScience"
        case .fantasy:
            "Fantasy"
        case .business:
            "Business"
        }
    }
}

