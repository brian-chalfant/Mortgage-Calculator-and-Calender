//
//  Cal.swift
//  Mortgage Calculator and Calender
//
//  Created by Jesse & Myra Bukoski on 3/20/21.
//

import SwiftUI


private extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

private extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let content: (Date) -> DateView

    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }

    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
    }
}

struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let showHeader: Bool
    let content: (Date) -> DateView

    init(
        month: Date,
        showHeader: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.content = content
        self.showHeader = showHeader
    }

    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }

    private var header: some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .monthAndYear
        return Text(formatter.string(from: month))
            .font(.title)
            .padding()
    }

    var body: some View {
        VStack {
            if showHeader {
                header
            }

            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let content: (Date) -> DateView

    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(months, id: \.self) { month in
                    MonthView(month: month, content: self.content)
                }
            }
        }
    }
}

struct RootView: View {
    @Environment(\.calendar) var calendar

    @State private var bgColor: Color = .green
    @State private var fgColor: Color = .purple
    @State var showingAlert: Bool = false
    @State var selectedDate: Date = Date()
    let textColor = UIColor(named: "tableBackgroundColor")
    let accColor = UIColor(named: "dateAccent")
    let gtcolor = UIColor(named: "TextColor")
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }

    var body: some View {

        CalendarView(interval: year) { date in
            
            Text("30")
                .hidden()
                .padding(10)
                .background(date == self.selectedDate ? fgColor : bgColor)
                //.background(date == self.clickedDate ? Color.gray : Color.blue)
                .clipShape(Circle()).glow(color: Color(accColor!), radius: 8)
                .padding(.vertical, 2)
                .padding(.horizontal, 1)
                .font(.body)
                .overlay(
                    Text(String(self.calendar.component(.day, from: date)))
                )
                .font(.caption2)
                .onTapGesture() {
                    self.selectedDate = date
                    self.showingAlert = true
                    
                }
            
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("An Accepted Offer on \(Text(selectedDate, style: .date))"), message: Text("Earliest Closing Date: \(Text(selectedDate + 3.456e+6, style: .date))"), primaryButton: .default(Text("Okay!")),
                secondaryButton: .destructive(Text("Cancel"))
                    
            )
                
            
        })
        .frame(width: 500, height: 790, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(textColor!))
        .foregroundColor(Color(gtcolor!))
        
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().colorScheme(.dark)
        RootView().colorScheme(.light)
    }
}
