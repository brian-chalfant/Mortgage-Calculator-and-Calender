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
        UISegmentedControl.appearance().backgroundColor = UIColor(named: "grayscale")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "TextColor") ?? Color.red ], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "TextColor") ?? Color.red ], for: .normal)
        

        }
    
    @State var mortgageValue = ""
    @State var AnnualPercentageRate = ""
    @State var selection = 0
    @State var mortgageType = [10, 15, 25, 30]
    @State var downPayment = ""
    @State var ShowTable = false
    @State var additionalPayment = ""
    //let colorone = Color(.lightGray)
    //let colortwo = Color(.black)
    let textColor = UIColor(named: "tableBackgroundColor")
    let fgColor = UIColor(named: "accentColor")
    let gtcolor = UIColor(named: "glowTextColor")
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
                            .glow(color: Color(fgColor!), radius: 12).foregroundColor(.black)
                            .font(.body)) {
                    TextField("Mortgage Amount", text: $mortgageValue)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(Color(fgColor!))
                        
                }.padding(.horizontal)
                .background(Color(textColor!))
                
                
                
                Section(header: Text("Interest Rate %")
                            .glow(color: Color(fgColor!), radius: 12).foregroundColor(.black)
                            .font(.body)) {
                    TextField("Interest Rate", text: $AnnualPercentageRate)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(Color(fgColor!))
                }
                .padding(.horizontal)
                .background(Color(textColor!))
                Section (header: Text("Down Payment")
                            .glow(color: Color(fgColor!), radius: 12).foregroundColor(.black)
                            .font(.body)){
                    TextField("Down Payment", text: $downPayment)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(Color(fgColor!))
                }
                .padding(.horizontal)
                .background(Color(textColor!))
                
                Section (header: Text("Loan Term (Years)")
                            .glow(color: Color(fgColor!), radius: 12).foregroundColor(.black)
                            .font(.body)) {
                    Picker("Length Of Loan", selection: $selection) {
                        ForEach(0 ..< mortgageType.count) {
                            Text("\(self.mortgageType[$0]) Years")
                                .foregroundColor(Color(gtcolor!))
                                //.background(Color(colorthree!))
                        }
                        .listRowInsets(EdgeInsets())
                        .foregroundColor(Color(gtcolor!))
                        .background(Color(fgColor!))
                        
                    }
                    .frame(maxWidth: .infinity)
                    //.background(Color(fgColor!))
                    .pickerStyle(SegmentedPickerStyle())
                    .border(borderColor, width: 3.0)
                    //.background(colorone)
                }
                .background(Color(textColor!))
                Section (header: Text("Monthy Payment")
                            .glow(color: Color(fgColor!), radius: 12).foregroundColor(.black)
                            .font(.body))  {
                    Text("$\(monthlyPayments.0, specifier: "%.2f")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(Color(fgColor!))
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                .background(Color(textColor!))
                Section (header: Text("Interest Paid")
                            .glow(color: Color(fgColor!), radius: 12).foregroundColor(.black)
                            .font(.body)) {
                    Text("$\(monthlyPayments.1, specifier: "%.2f")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(Color(fgColor!))
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                Section (header: Text("Additional Payment each Month")
                            .glow(color: Color(fgColor!), radius: 12).foregroundColor(.black)
                            .font(.body)) {
                    TextField("Additional Payment", text: $additionalPayment)
                        .padding()
                        .listRowInsets(EdgeInsets())
                        .border(borderColor, width: 3.0)
                        .foregroundColor(Color(fgColor!))
                        .foregroundColor(.black)
                }

                
                .padding(.horizontal)
                .background(Color(textColor!))
                //TODO: Pie Chart, Loan payment Table
                 //
                Button("Amortization Table")
                {
                    self.ShowTable.toggle()
                }
                .frame(maxWidth: .infinity,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .listRowInsets(EdgeInsets())
                .foregroundColor(Color(gtcolor!))
                .font(.title)
                .border(borderColor)
                .glow(color: Color(fgColor!), radius: 12)
                .background(Color(textColor!))
                .sheet(isPresented: $ShowTable, content: {

                    mortgage_table(
                        totalAmount: monthlyPayments.2,
                        beginningBalance: monthlyPayments.2, interestRate: monthlyPayments.3, monthlyPayment: monthlyPayments.0, numberOfPayments: monthlyPayments.4 * 12,
                        additionalPayments: monthlyPayments.5)
                })

                    
            }//.foregroundColor(colorfour)
            .background(Color(textColor!))
            //.keyboardType(.decimalPad)
        }
        
        }
    }
    

struct Calc_Previews: PreviewProvider {
    static var previews: some View {
        Calc().colorScheme(.dark)
        Calc().colorScheme(.light)
    }
}

