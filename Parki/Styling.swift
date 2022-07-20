//
//  Styling.swift
//  Parki
//
//  Created by Yi Qin on 7/17/22.
//

import SwiftUI


// styling for header
struct Header: View {
    let text: String
    
    var body: some View {
        Text("\(text)")
            .foregroundColor(.headerColor)
            .font(.custom(Font.semiBold, size: 20))
    }
}

// styling for main btn
struct MainBtn: View {
    
    let label: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.primaryColor)
                .frame(width: 0.825 * UIScreen.screenWidth, height: 0.059 * UIScreen.screenHeight)
            Text("\(label)")
                .foregroundColor(.primaryTextColor)
                .font(.custom(Font.semiBold, size: 20))
        }
    }
}


// view for icon
struct Icon: View {
    var body: some View {
        HStack {
            Image("Icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 0.094 * UIScreen.screenWidth)
                .padding(.trailing, 0.084 * UIScreen.screenWidth)
        }.frame(width: UIScreen.screenWidth, alignment: .trailing)
    }
}

extension Text {
    
}

// for navigation
struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}
extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar())
    }
}

// for easy access to colors
extension Color {
    static let backgroundColor = Color("BackgroundColor")
    
    static let headerColor = Color("HeaderColor")
    
    static let primaryColor = Color("PrimaryColor")
    static let primaryTextColor = Color("PrimaryTextColor")
    
    static let secondaryColor = Color("SecondaryColor")
    static let secondaryTextColor = Color("SecondaryTextColor")
    
    static let dropShadowColor = Color("PrimaryColor")
}

// access to screen sizes
extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}

// access to fonts - only Regular, Medium, and SemiBold are imported from info.plist
extension Font {
    static let regular = "Montserrat-Regular"
    static let medium = "Montserrat-Medium"
    static let semiBold = "Montserrat-SemiBold"
}

////
////  Parki_Widget.swift
////  Parki-Widget
////
////  Created by Yi Qin on 7/17/22.
////
//
//import WidgetKit
//import SwiftUI
//import Parki
////import Intents
//
//struct ParkedFloorEntry: TimelineEntry {
//    let date = Date()
//    let floor: Int
//}
//
//// tells the app widget when they need to be updated again
//struct Provider: TimelineProvider {
//    
//    let floor = UserDefaults.standard.integer(forKey: "ParkedFloor")
//    
//    func placeholder(in context: Context) -> ParkedFloorEntry {
//        ParkedFloorEntry(floor: 2)
//    }
//    
//    func getSnapshot(in context: Context, completion: @escaping (ParkedFloorEntry) -> Void) {
//        let entry = ParkedFloorEntry(floor: self.floor)
//        completion(entry)
//    }
//    
//    func getTimeline(in context: Context, completion: @escaping (Timeline<ParkedFloorEntry>) -> Void) {
//        let entry = ParkedFloorEntry(floor: self.floor)
//        let timeline = Timeline(entries: [entry], policy: .never)
//        completion(timeline)
//    }
//}
//
//
//struct PlaceholderView: View {
//    var body: some View {
//        ZStack {
//            Text("PlaceholderView")
//        }
//    }
//}
//
//struct WidgetEntryView: View {
//    let entry: Provider.Entry
//    
//    var body: some View {
//        Text("WidgetEntryView: \(entry.floor)")
//    }
//}
//
//@main
//struct Parki_Widget: Widget {
//    let kind: String = "Parki_Widget"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            WidgetEntryView(entry: entry)
//        }
//        .configurationDisplayName("Parki Widget")
//        .description("This widget helps you remember where you parked your car.")
//    }
//}
