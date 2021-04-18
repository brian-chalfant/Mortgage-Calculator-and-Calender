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
    let textColor = UIColor(named: "tableBackgroundColor")
    let fgColor = UIColor(named: "accentColor")
    let gtcolor = UIColor(named: "glowTextColor")
    var body: some View {
        ZStack {
            VStack{
                Image(systemName: "house.fill").scaleEffect()
                    .glow(color: Color(fgColor!))
                    .padding(.top, 60)
                Text("Mortgage Calendar \n and Calculator")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2.0)
                    .glow(color: Color(fgColor!), radius: 3)
                    
                HStack {
                        Spacer()
                            Button("\(Image(systemName: "minus.slash.plus"))  Calculator") {
                            self.ShowingCalc.toggle()
                            }.sheet(isPresented: $ShowingCalc, content: {
                                Calc()
                            })
                            .buttonStyle(FilledButton())
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
            .background(Color(textColor!)
            )}
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().colorScheme(.dark)
        HomeView().colorScheme(.light)
    }
}

struct FilledButton: ButtonStyle {
    let fgColor = UIColor(named: "accentColor")
    let textColor = UIColor(named: "tableBackgroundColor")
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .black)
            .frame(width: 200, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            //.background(Color(textColor!))
            //.foregroundColor(.blue)
            .cornerRadius(200)
            .glow(color: Color(fgColor!), radius: 36)
    }
}
