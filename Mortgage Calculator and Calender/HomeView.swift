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
    var body: some View {
        VStack{
            Form {
                Section (header: Text("Tools")) {
                    Button("Calculator") {
                        self.ShowingCalc.toggle()
                    }.sheet(isPresented: $ShowingCalc, content: {
                        Calc()
                    })
                    Button("Calendar") {
                        self.ShowingCal.toggle()
                    }.sheet(isPresented: $ShowingCal, content: {
                        Cal()
                    })
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
