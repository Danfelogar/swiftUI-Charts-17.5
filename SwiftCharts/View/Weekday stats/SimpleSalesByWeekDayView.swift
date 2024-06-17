import SwiftUI
import Charts

struct SimpleSalesByWeekdayView: View {
    //States
    @ObservedObject var salesViewModel: SalesViewModel
    
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
            Chart(salesViewModel.averageSalesByWeekday, id: \.number) {
                    BarMark(x: .value("Day", weekday(for: $0.number)),
                            y: .value("Sales", $0.sales))
                    .opacity($0.number == salesViewModel.highestSellingWeekday?.number ? 1 : 0.3)
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(height: 50)
        }//VStack
    }
}

#Preview {
    SimpleSalesByWeekdayView(salesViewModel: .preview)
        .padding()
}
