//
//  chartview.swift
//  Mortgage Calculator and Calender
//
//  Created by Brian Chalfant on 3/25/21.
//

import SwiftUICharts;
import SwiftUI

struct chartview: View {
    var body: some View {
        let interest = Legend(color: .blue, label: "Interest", order: 2)
        let principle = Legend(color: .gray, label: "Principle", order: 1)

        let points: [DataPoint] = [
            .init(value: 670, label: "", legend: interest),
            .init(value: 500, label: "2", legend: principle),
        ]

        HorizontalBarChartView(dataPoints: points)
        
    }
}

struct chartview_Previews: PreviewProvider {
    static var previews: some View {
        chartview()
    }
}
