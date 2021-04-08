//
//  Calc.swift
//  Mortgage Calculator and Calender
//
//  Created by Brian Chalfant on 3/18/21.
//

import SwiftUI



struct Calc: View {
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    @State var mortgageValue = ""
    @State var AnnualPercentageRate = ""
    @State var selection = 0
    @State var mortgageType = [10, 15, 25, 30]
    @State var downPayment = ""
    @State var ShowTable = false
    @State var additionalPayment = ""
    let colorone = Color(.lightGray)
    let colortwo = Color(.black)
    let colorthree = Color(.black)
    let colorfour = Color(.white)
    
    
    var monthlyPayments: (Double, Double, Double, Double, Int, Double) {
        // Calculated variable
        let dp = Double(downPayment) ?? 0
        let years = mortgageType[selection]
        let totalValue = Double(mortgageValue) ?? 0
        let apr = Double(AnnualPercentageRate) ?? 0
        let addnum = Double(additionalPayment) ?? 0
        let r = (apr/100)/12
        let n = Double(years * 12)
        //M = P[r(1+r)^n/((1+r)^n)-1)]
        let top = r * pow(1+r,n)
        let bottom = pow(1+r, n)-1
        if (totalValue > 0 && apr > 0) {
            let payment =  (totalValue - dp) * (top/bottom)
            let interestPaid = Double((Double(years * 12) * payment) - (totalValue-dp))
            
            return (payment, interestPaid, totalValue-dp, r, years, addnum)
        } else {
            return (0.0, 0.0, 0.0, 0.0,  0, 0.0)
        }
        //(years * 12 * payment amount) - loan amount
    }

    var body: some View {
        VStack{
            
            Form {
                Section(header: Text("Mortgage Amount $").glow(color: Color.blue, radius: 12)) {
                    TextField("Mortgage Amount", text: $mortgageValue)
                }
                Section(header: Text("Interest Rate %").glow(color: Color.blue, radius: 12)) {
                    TextField("Interest Rate", text: $AnnualPercentageRate)
                }
                Section (header: Text("Down Payment").glow(color: Color.blue, radius: 12)){
                    TextField("Down Payment", text: $downPayment)
                }
                Section (header: Text("Length of Loan in Years").glow(color: Color.blue, radius: 12)) {
                    Picker("Length Of Loan", selection: $selection) {
                        ForEach(0 ..< mortgageType.count) {
                            Text("\(self.mortgageType[$0]) Years")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .background(colorone)
                }
                Section (header: Text("Monthy Payment").glow(color: Color.blue, radius: 12)) {
                    Text("$\(monthlyPayments.0, specifier: "%.2f")")
                        .foregroundColor(.black)
                }
                Section (header: Text("Interest Paid").glow(color: Color.blue, radius: 12)) {
                    Text("$\(monthlyPayments.1, specifier: "%.2f")")
                        .foregroundColor(.black)
                }
                Section (header: Text("Additional Payment each Month").glow(color: Color.blue, radius: 12)) {
                    TextField("Additional Payment", text: $additionalPayment)
                }
                //TODO: Pie Chart, Loan payment Table
                 //
                Button("Amortization Table") {
                    self.ShowTable.toggle()
                }.sheet(isPresented: $ShowTable, content: {

                    mortgage_table(
                        totalAmount: monthlyPayments.2,
                        beginningBalance: monthlyPayments.2, interestRate: monthlyPayments.3, monthlyPayment: monthlyPayments.0, numberOfPayments: monthlyPayments.4 * 12,
                        additionalPayments: monthlyPayments.5)
                })
                .frame(width: 300, height: 50,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.white)
                .foregroundColor(.black)
                .font(.body)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .glow(color: Color.blue, radius: 12)
                    
            }.foregroundColor(colorfour)
            .background(LinearGradient(gradient: Gradient(colors: [colortwo, colorthree]), startPoint: .topLeading, endPoint: .bottomTrailing))
            //.keyboardType(.decimalPad)
        }
        
        }
    }
    

struct Calc_Previews: PreviewProvider {
    static var previews: some View {
        Calc()
    }
}

