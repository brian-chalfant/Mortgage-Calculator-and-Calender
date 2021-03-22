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
    
    var body: some View {
        let mort_table = generateTable(totalAmount: totalAmount, balance: beginningBalance, interestRate: interestRate, monthlyPayment: monthlyPayment, numberOfPayments: numberOfPayments)
        VStack {
        tableHeader()
            ForEach(mort_table, id: \.self) {row in
            tableRow(date: dateToString(date: startDate), payment: row[0], principle: row[2], interest: row[1], balance: row[3])
            
            //self.beginningBalance = (beginningBalance - (monthlyPayment - (beginningBalance * interestRate)))
            
            
        }
        }
    }
}

struct tableHeader: View {
    var body: some View {
    HStack() {
        Group() {
            Text("Date")
            Spacer()
            Text("Payment")
            Text("Principle")
            Text("Interest")
            Spacer()
            Text("Balance")
        }
    }.font(.caption)
}
}

struct tableRow: View {
    var date: String
    var payment: Double
    var principle: Double
    var interest: Double
    var balance: Double
    var body: some View {
    HStack() {
        Group() {
            Text(date)
            Spacer()
            Text("\(payment, specifier: "%.2f")")
            Text("\(principle, specifier: "%.2f")")
            Text("\(interest, specifier: "%.2f")")
            Spacer()
            Text("\(balance, specifier: "%.2f")")
        }
    }.font(.caption)
}
}



struct mortgage_table_Previews: PreviewProvider {
    static var previews: some View {
        mortgage_table(totalAmount: 100000.0, beginningBalance: 100000.0, interestRate: 0.3/12, monthlyPayment: 1000.00, numberOfPayments: 10)
    }
}


func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM YY"
    return formatter.string(from: date)
    
}

func generateTable(totalAmount: Double, balance: Double, interestRate: Double, monthlyPayment: Double, numberOfPayments: Int) -> [[Double]] {
    var mort_table: [[Double]] =  []
    var beginningBalance = balance
    for _ in 0..<numberOfPayments {
        var tableRow: [Double] = []
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
        
        beginningBalance = balance
        
    }
    print(mort_table)
    return mort_table
    
    
    
    }
