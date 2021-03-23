//
//  mortgage_table.swift
//  Mortgage Calculator and Calender
//
//  Created by Brian Chalfant on 3/21/21.
//

import SwiftUI


struct mortgage_table: View {
    
    @State var totalAmount: Double
    @State var beginningBalance: Double
    @State var interestRate: Double
    @State var monthlyPayment: Double
    @State var numberOfPayments: Int
    @State var startDate = Date()
    
    
    
    let colorone = Color(red: 244.0/255, green: 249.0/255, blue: 249.0/255)
    let colortwo = Color(red: 204.0/255, green: 242.0/255, blue: 244.0/255)
    let colorthree = Color(red:164.0/255, green: 235.0/255, blue: 243.0/255)
    let colorfour = Color(red: 170.0/255, green: 170.0/255, blue: 170.0/255)
    
    var body: some View {
        let (mort_table, date_table) = generateTable(totalAmount: totalAmount, balance: beginningBalance, interestRate: interestRate, monthlyPayment: monthlyPayment, numberOfPayments: numberOfPayments)
        
                Form {
                    VStack {
                        tableHeader()
                        Rectangle()
                            .fill(colorfour)
                            .padding(.bottom, 0.25)
                        .background(colorfour)
                        ForEach(0..<mort_table.count, id: \.self) {i in
                            tableRow(date: date_table[i],
                             payment: mort_table[i][0],
                             interest: mort_table[i][1],
                             principle: mort_table[i][2],
                             balance: mort_table[i][3])
                                .padding(1)
            
            
                        }

                    }.listRowBackground(LinearGradient(gradient: Gradient(colors: [colortwo, colorthree]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                }
                .opacity(0.8)
                .background(colortwo)
        
    }
}
struct tableHeader: View {
    var body: some View {
    HStack() {
            Text("Date")
            Spacer()
            Text("Payment")
            Text("Principle")
            Text("Interest")
            Spacer()
            Text("Balance")
            Spacer()
    }.font(Font.caption.weight(.bold))
}
}

struct tableRow: View {
    var date: String
    var payment: Double
    var interest: Double
    var principle: Double
    var balance: Double
    var body: some View {
    HStack() {
        Text(date).font(Font.caption.weight(.thin))
            Spacer()
            Text("$\(payment, specifier: "%.2f")")
            Spacer()
            Text("$\(principle, specifier: "%.2f")")
            Spacer()
            Text("$\(interest, specifier: "%.2f")")
            Spacer()
            Text("$\(balance, specifier: "%.2f")")
    }.font(.caption)
}
}



struct mortgage_table_Previews: PreviewProvider {
    static var previews: some View {
        mortgage_table(totalAmount: 100000.0, beginningBalance: 100000.0, interestRate: 0.03/12, monthlyPayment: 956.61, numberOfPayments: 30)
    }
}




func generateTable(totalAmount: Double, balance: Double, interestRate: Double, monthlyPayment: Double, numberOfPayments: Int) -> ([[Double]], [String]) {
    var startDate = Date()
    var date_table: [String] = []
    var mort_table: [[Double]] =  []
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM YY"
    var beginningBalance = balance
    for _ in 0..<numberOfPayments {
        var tableRow: [Double] = []
        date_table.append(formatter.string(from: startDate))
        // append montly payment
        tableRow.append(monthlyPayment)
        // append interest
        let interest = beginningBalance * interestRate
        tableRow.append(interest)
        // append principle
        let principle = (monthlyPayment - interest)
        tableRow.append(principle)

        // append balance
        let balance = (beginningBalance - principle)
        tableRow.append(balance)
        mort_table.append(tableRow)
        
        // set ending balance to beginning balance for next month
        beginningBalance = balance
        // advance date one month
        startDate.addTimeInterval(2.628e+6)
        
    }
    print(mort_table)
    return (mort_table, date_table)
    
    
    
    }
