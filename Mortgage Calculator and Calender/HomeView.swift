//
//  ContentView.swift
//  Mortgage Calculator and Calender
//
//  Created by Brian Chalfant on 3/18/21.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack{
            NavigationView {
                Form {
                    Section {
                        Text("Calculator")
                    }
                }
                .navigationBarTitle(Text("Mortgage Helper"), displayMode: .inline)
            }
            Text("Mortgage Helper")
            .font(.headline)
            .padding()
            NavigationView {
                NavigationLink(destination: Calc()) {
                    Label("Calculater", systemImage: "plusminus.circle.fill")
                }
                
            }
            NavigationView {
                NavigationLink(destination: Calc()) {
                    Label("Calender", systemImage: "calendar")
           
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
