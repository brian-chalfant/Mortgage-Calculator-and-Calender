//
//  ContentView.swift
//  Mortgage Calculator and Calender
//
//  Created by Brian Chalfant on 3/18/21.
//

import SwiftUI

struct HomeView: View {
    @State private var ShowingCalc = false
    @State private var ShowingCal = false
    let colorone = Color(.lightGray)
    let colortwo = Color(#colorLiteral(red: 0.9198163748, green: 0.720421195, blue: 0.4714105129, alpha: 1))
    let colorthree = Color(.cyan)
    let colorfour = Color(.gray)
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                Image(systemName: "house.fill").scaleEffect()
                Text("Mortgage Calender \n and Calculator")
                    .font(.system(size: 43.0))
                    .multilineTextAlignment(.center)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2.0)
                    
                    
                Spacer()
                HStack {
                        Spacer()
                            Button("\(Image(systemName: "minus.slash.plus"))  Calculator") {
                            self.ShowingCalc.toggle()
                            }.sheet(isPresented: $ShowingCalc, content: {
                                Calc()
                            }).buttonStyle(FilledButton())
                        Spacer()
                        }
                HStack {
                        Spacer()
                            Button("\(Image(systemName: "calendar"))  Calendar") {
                            self.ShowingCal.toggle()
                            }.sheet(isPresented: $ShowingCal, content: {
                                RootView()
                            }).buttonStyle(FilledButton())
                        Spacer()
                        }
                
            }.background(LinearGradient(gradient: Gradient(colors: [colortwo, colorthree]), startPoint: .topLeading, endPoint: .bottomTrailing)).ignoresSafeArea()
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct FilledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .black)
            .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(200)
    }
}
