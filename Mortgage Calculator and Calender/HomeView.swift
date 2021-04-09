//
//  ContentView.swift
//  Mortgage Calculator and Calender
//
//  Created by Brian Chalfant on 3/18/21.
//

import SwiftUI

extension View {
    func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}

struct HomeView: View {
    @State private var ShowingCalc = false
    @State private var ShowingCal = false
    let colorone = Color(.lightGray)
    let colortwo = Color(.black)
    let colorthree = Color(.black)
    let colorfour = Color(.white)
    var body: some View {
        ZStack {
            VStack{
                Image(systemName: "house.fill").scaleEffect()
                    .glow(color: Color.white)
                    .padding(.top, 60)
                Text("Mortgage Calendar \n and Calculator")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2.0)
                    .glow(color: Color.white, radius: 3)
                    
                HStack {
                        Spacer()
                            Button("\(Image(systemName: "minus.slash.plus"))  Calculator") {
                            self.ShowingCalc.toggle()
                            }.sheet(isPresented: $ShowingCalc, content: {
                                Calc()
                            }).buttonStyle(FilledButton())
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Spacer()
                        }
                .padding()
                HStack {
                        Spacer()
                            Button("\(Image(systemName: "calendar"))  Calendar") {
                            self.ShowingCal.toggle()
                            }.sheet(isPresented: $ShowingCal, content: {
                                RootView()
                            }).buttonStyle(FilledButton())
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Spacer()
                        }
                        Spacer()
                // Add UI Color Choices
                // Neon, Homebrew, options?
                //Toggle("")
            
            }
            .background(LinearGradient(gradient: Gradient(colors: [colortwo, colorthree]), startPoint: .topLeading, endPoint: .bottomTrailing)).ignoresSafeArea()
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
            .frame(width: 200, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            .background(Color.white)
            .cornerRadius(200)
            .glow(color: Color.blue, radius: 36)
    }
}
