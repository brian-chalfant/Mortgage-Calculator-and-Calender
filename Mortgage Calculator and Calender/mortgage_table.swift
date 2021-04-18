//
//  mortgage_table.swift
//  Mortgage Calculator and Calender
//
//  Created by Brian Chalfant on 3/21/21.
//

import SwiftUI
import SwiftUICharts


struct mortgage_table: View {
    
    @State var totalAmount: Double
    @State var beginningBalance: Double
    @State var interestRate: Double
    @State var monthlyPayment: Double
    @State var numberOfPayments: Int
    @State var startDate = Date()
    @State var additionalPayments: Double
    let interest = Legend(color: .blue, label: "Interest", order: 2)
    let principle = Legend(color: .gray, label: "Principle", order: 1)
    let grayscale = UIColor(named: "grayscale")
    let textColor = UIColor(named: "TextColor")
    let tableBackgroundColor = UIColor(named: "tableBackgroundColor")
    var body: some View {
        let (mort_table, date_table, points, observations) = generateTable(totalAmount: totalAmount, balance: beginningBalance, interestRate: interestRate, monthlyPayment: monthlyPayment, numberOfPayments: numberOfPayments, additionalPayments: additionalPayments)
                Form {
                    VStack {
                        VStack {
                            HorizontalBarChartView(dataPoints: points).font(.body)
                            if (additionalPayments > 0) {
                                VStack() {
                                    HStack() {
                                        Text("$\(additionalPayments, specifier: "%.2f") Additional Per Month:").foregroundColor(Color(textColor!))
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Pay off \(observations[2], specifier: "%.0f") months ( \(observations[2]/12, specifier: "%.1f") years) Early").foregroundColor(Color(textColor!))
                                        Spacer()
                                    }
                                    HStack {
                                //MARK: - TODO if year == 1 specify year not years
                                        Text("Save $\(observations[0], specifier: "%.2f") in interest").foregroundColor(Color(textColor!))
                                        Spacer()
                                    }
                                }.font(.caption)
                                .foregroundColor(.black)
                            }
                        }
                            .padding()
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        tableHeader()
                        Rectangle()
                            .fill(Color(grayscale!))
                            .padding(.bottom, 0.25)
                            .background(Color(grayscale!))
                        ForEach(0..<mort_table.count, id: \.self) {i in
                            tableRow(date: date_table[i],
                             payment: mort_table[i][2],
                             interest: mort_table[i][0],
                             principle: mort_table[i][1],
                             balance: mort_table[i][3])
                                .padding(1)
            
            
                        }

                    }//.listRowBackground(LinearGradient(gradient: Gradient(colors: [colortwo, colorthree]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                }
                .opacity(0.8)
                .background(Color(tableBackgroundColor!))
                .foregroundColor(Color(textColor!))
        
    }
}
struct tableHeader: View {
    var body: some View {
    HStack() {
            Text("Date")
            Spacer()
            Text("Payment")
            Spacer()
            Text("Principle")
            Spacer()
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
        Text(date).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            Text("$\(payment, specifier: "%.2f")")
            Spacer()
            Text("$\(principle, specifier: "%.2f")")
            Spacer()
            Text("$\(interest, specifier: "%.2f")")
            Spacer()
            Text("$\(balance, specifier: "%.2f")")
    }.font(.system(size: 10, design: .monospaced))
    
}
}



struct mortgage_table_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        mortgage_table(totalAmount: 100000.0, beginningBalance: 100000.0, interestRate: 0.03/12, monthlyPayment: 956.61, numberOfPayments: 120, additionalPayments: 100.0)
            .colorScheme(.light)
            mortgage_table(totalAmount: 100000.0, beginningBalance: 100000.0, interestRate: 0.03/12, monthlyPayment: 956.61, numberOfPayments: 120, additionalPayments: 100.0)
            .colorScheme(.dark)
        }
    }
}




func generateTable(totalAmount: Double, balance: Double, interestRate: Double, monthlyPayment: Double, numberOfPayments: Int, additionalPayments: Double) -> ([[Double]], [String], [DataPoint], [Double]) {
    print(additionalPayments)
    var startDate = Date()
    var date_table: [String] = []
    var mort_table: [[Double]] =  []
    let interestLegend = Legend(color: .yellow, label: "Interest", order: 2)
    let principleLegend = Legend(color: .green, label: "Principle", order: 1)
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM YY"
    var beginningBalance = balance
    var totalInterest = 0.0
    var interest_percentage = 0.0
    var totalPrinciple = 0.0
    var principle_percentage = 0.0
    var totalPaid = 0.0
    let deltaP = additionalPayments
    var observations: [Double] = []
    var monthCounter = 0.0
    //for _ in 0..<numberOfPayments {
    while (beginningBalance > 0.0) {
        monthCounter += 1.0
        var tableRow: [Double] = []
        var principle = 0.0
        var payment = 0.0
        date_table.append(formatter.string(from: startDate))
        // append montly payment
        
        // append interest
        let interest = beginningBalance * interestRate
        tableRow.append(interest)
        totalInterest += interest
        // amount owed is less than normal payment
        if (interest + beginningBalance < monthlyPayment + deltaP) {
            payment = interest + beginningBalance
            principle = beginningBalance
            totalPrinciple += principle
            tableRow.append(principle)
            tableRow.append(payment)
        } else {
            payment = monthlyPayment + deltaP
            principle = (payment - interest)
            totalPrinciple += principle
            tableRow.append(principle)
            tableRow.append(payment)
        }
        // append monthly payment
        
        // append balance
        let balance = (beginningBalance - principle)
        tableRow.append(balance)
        mort_table.append(tableRow)
        
        // set ending balance to beginning balance for next month
        beginningBalance = balance
        // advance date one month
        startDate.addTimeInterval(2.628e+6)
        
    }
    totalPaid = monthlyPayment * Double(numberOfPayments)
    observations.append(totalPaid - (totalPrinciple+totalInterest))
    observations.append((totalPaid-totalAmount)-totalInterest)
    observations.append(Double(numberOfPayments) - monthCounter)
    principle_percentage = totalPrinciple / (totalPrinciple + totalInterest)
    interest_percentage = totalInterest / (totalPrinciple + totalInterest)
    
    if (principle_percentage.isNaN) {
        principle_percentage = 0.0
    }
    if (interest_percentage.isNaN) {
        interest_percentage = 0.0
    }
    let points: [DataPoint] = [
        .init(value: totalPrinciple, label: "\(principle_percentage * 100, specifier: "%.2f")%", legend: principleLegend),
        .init(value: totalInterest, label: "\(interest_percentage * 100, specifier: "%.2f")%", legend: interestLegend),
    ]
    return (mort_table, date_table, points, observations)
    
    
    
}
