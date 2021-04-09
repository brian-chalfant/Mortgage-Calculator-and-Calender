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
            //UISegmentedControl.appearance().selectedSegmentTintColor = .blue
            UISegmentedControl.appearance().backgroundColor = .black
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            //UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
        

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
    let neonColor = Color.black
    let fgColor = Color.green
    let borderColor = Color.black
    
    
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
                Section(header: Text("Mortgage Amount $")
                            .glow(color: neonColor, radius: 12)
                            .font(.body)) {
                    TextField("Mortgage Amount", text: $mortgageValue)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(fgColor)
                        
                }.padding(.horizontal)
                .background(Color.black)
                
                
                
                Section(header: Text("Interest Rate %")
                            .glow(color: neonColor, radius: 12)
                            .font(.body)) {
                    TextField("Interest Rate", text: $AnnualPercentageRate)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(fgColor)
                }
                .padding(.horizontal)
                .background(Color.black)
                Section (header: Text("Down Payment")
                            .glow(color: neonColor, radius: 12)
                            .font(.body)){
                    TextField("Down Payment", text: $downPayment)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(fgColor)
                }
                .padding(.horizontal)
                .background(Color.black)
                
                Section (header: Text("Loan Term (Years)")
                            .glow(color: neonColor, radius: 12)
                            .font(.body)) {
                    Picker("Length Of Loan", selection: $selection) {
                        ForEach(0 ..< mortgageType.count) {
                            Text("\(self.mortgageType[$0]) Years")
                                .foregroundColor(fgColor)
                                .background(Color.black)
                        }
                        .foregroundColor(fgColor)
                        .listRowInsets(EdgeInsets())
                        .background(Color.black)

                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .pickerStyle(SegmentedPickerStyle())
                    .border(borderColor, width: 3.0)
                    //.background(colorone)
                }
                .background(Color.clear)
                Section (header: Text("Monthy Payment")
                            .glow(color: neonColor, radius: 12)
                            .font(.body))  {
                    Text("$\(monthlyPayments.0, specifier: "%.2f")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(fgColor)
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                .background(Color.black)
                Section (header: Text("Interest Paid")
                            .glow(color: neonColor, radius: 12)
                            .font(.body)) {
                    Text("$\(monthlyPayments.1, specifier: "%.2f")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(fgColor)
                        .foregroundColor(.black)
                        //.foregroundColor(.black)
                }
                .padding(.horizontal)
                .background(Color.black)
                Section (header: Text("Additional Payment each Month")
                            .glow(color: neonColor, radius: 12)
                            .font(.body)) {
                    TextField("Additional Payment", text: $additionalPayment)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(fgColor)
                        .foregroundColor(.black)
                }

                
                .padding(.horizontal)
                .background(Color.black)
                //TODO: Pie Chart, Loan payment Table
                 //
                Button("Amortization Table")
                {
                    self.ShowTable.toggle()
                }
                .frame(maxWidth: .infinity,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .listRowInsets(EdgeInsets())
                .background(Color.black)
                .foregroundColor(fgColor)
                .font(.title)
                .border(borderColor)
                .glow(color: neonColor, radius: 12)
                .background(Color.black)
                .sheet(isPresented: $ShowTable, content: {

                    mortgage_table(
                        totalAmount: monthlyPayments.2,
                        beginningBalance: monthlyPayments.2, interestRate: monthlyPayments.3, monthlyPayment: monthlyPayments.0, numberOfPayments: monthlyPayments.4 * 12,
                        additionalPayments: monthlyPayments.5)
                })

                    
            }//.foregroundColor(colorfour)
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

