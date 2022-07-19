//
//  Parki_Widget.swift
//  Parki_Widget
//
//  Created by Yi Qin on 7/17/22.
//

import WidgetKit
import SwiftUI

//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date())
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date())
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//}
//
//struct Parki_WidgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        Text(entry.date, style: .time)
//    }
//}
//
//@main
//struct Parki_Widget: Widget {
//    let kind: String = "Parki_Widget"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            Parki_WidgetEntryView(entry: entry)
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//    }
//}
//
//struct Parki_Widget_Previews: PreviewProvider {
//    static var previews: some View {
//        Parki_WidgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}


//import Intents

struct ParkedFloorEntry: TimelineEntry {
    var date = Date()
    var floor: Int
    var updateTime: Date
}

// tells the app widget when they need to be updated again
struct Provider: TimelineProvider {

    //let floor = UserDefaults.standard.integer(forKey: "ParkedFloor")
    @AppStorage("ParkedFloor", store: UserDefaults(suiteName: "group.com.Parki.Parki")) var floor: Int = 0
    @AppStorage("ParkedTime", store: UserDefaults(suiteName: "group.com.Parki.Parki")) var updateTime: Date = Date()

    func placeholder(in context: Context) -> ParkedFloorEntry {
        ParkedFloorEntry(floor: 2, updateTime: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (ParkedFloorEntry) -> Void) {
        let entry = ParkedFloorEntry(floor: self.floor, updateTime: self.updateTime)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ParkedFloorEntry>) -> Void) {
        let entry = ParkedFloorEntry(floor: self.floor, updateTime: self.updateTime)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}


struct PlaceholderView: View {
    var body: some View {
        ZStack {
            Text("PlaceholderView")
        }
    }
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    let timeElapsed: String
    
    init(entry: Provider.Entry) {
        self.entry = entry
        self.timeElapsed = getTimeElapsed(startTime: entry.updateTime)
    }

    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .top) {
                WidgetView(floor: entry.floor)
                
                // for the last modified time
                HStack {
                    Text("\(timeElapsed)")
                        .font(.custom(Font.regular, size: 11))
                        .scaledToFit()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(.secondaryTextColor.opacity(0.8))
                        .frame(width: 0.386 * geo.size.width)
                        .padding(.trailing, 0.113 * geo.size.width)
                }
                .frame(width: geo.size.width, alignment: .trailing)
                .padding(.top, 0.075 * geo.size.height)
            }.frame(alignment: .top)
        }
    }
}

@main
struct Parki_Widget: Widget {
    let kind: String = "Parki_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Parki Widget")
        .description("This widget helps you remember where you parked your car.")
    }
}

struct Parki_Widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: ParkedFloorEntry(floor: 2, updateTime: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
