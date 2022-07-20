//
//  TimeElapsed.swift
//  Parki
//
//  Created by Yi Qin on 7/18/22.
//

import SwiftUI


func getTimeElapsed(startTime: Date) -> String {
    
    let diff = startTime.timeIntervalSinceNow // difference in seconds
    
    var string = ""
    
    if abs(diff) < 300 {
        string = "Just now"
    } else {
        string = formatTimeElapsed(elapsedSeconds: diff) // add a minus sign to denote passed time
    }
    
    return string
}

// format the elapsed time
private func formatTimeElapsed(elapsedSeconds: Double) -> String {
    
    let date = Date().addingTimeInterval(elapsedSeconds) //ex. -15000 = 4 days

    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    let string = formatter.localizedString(for: date, relativeTo: Date())
    
    return string
}
// for storing date into @AppStorage
extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeElapsedView()
//    }
//}
