//
//  Calc.swift
//  Mortgage Calculator and Calender
//
//  Created by Brian Chalfant on 3/18/21.
//

import SwiftUI



struct Calc: View {
    @State var mortgageValue = ""
    @State var AnnualPercentageRate = ""
    @State var selection = 0
    @State var mortgageType = [10, 15, 25, 30]
    @State var downPayment = ""
    
    
    var monthlyPayments: (Double, Double) {
        // Calculated variable
        let dp = Double(downPayment) ?? 0
        let years = mortgageType[selection]
        let totalValue = Double(mortgageValue) ?? 0
        let apr = Double(AnnualPercentageRate) ?? 0
        let r = (apr/100)/12
        let n = Double(years * 12)
        //M = P[r(1+r)^n/((1+r)^n)-1)]
        let top = r * pow(1+r,n)
        let bottom = pow(1+r, n)-1
        if (top > 0) {
            let payment =  (totalValue - dp) * (top/bottom)
            let interestPaid = Double((Double(years * 12) * payment) - totalValue)
            
            return (payment, interestPaid)
        } else {
            return (0, 0)
        }
        //(years * 12 * payment amount) - loan amount
    }

    var body: some View {
        VStack{
            Form {
                Section(header: Text("Mortgage Amount")) {
                    TextField("Mortgage Amount", text: $mortgageValue)
                }
                Section(header: Text("Annual Percentage Rate")) {
                    TextField("Annual Percentage Rate", text: $AnnualPercentageRate)
                }
                Section (header: Text("Down Payment")){
                    TextField("Down Payment", text: $downPayment).keyboardType(.decimalPad)
                }
                Section (header: Text("Length of Loan in Years")) {
                    Picker("Length Of Loan", selection: $selection) {
                        ForEach(0 ..< mortgageType.count) {
                            Text("\(self.mortgageType[$0]) Years")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section (header: Text("Monthy Payment")) {
                    Text("$\(monthlyPayments.0, specifier: "%.2f")")
                }
                Section (header: Text("Interest Paid")) {
                    Text("$\(monthlyPayments.1, specifier: "%.2f")")
                } //TODO: Pie Chart, Loan payment Table
                 //
            }
            
        }
        
        }
    }
    

struct Calc_Previews: PreviewProvider {
    static var previews: some View {
        Calc()
    }
}

