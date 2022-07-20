//
//  DisplayView.swift
//  Parki
//
//  Created by Yi Qin on 7/18/22.
//

import SwiftUI

struct DisplayView: View {
    
    // for displaying the floor and the time elapsed
    @AppStorage("ParkedFloor", store: UserDefaults(suiteName: "group.com.Parki.Parki")) var floor: Int = 0
    @AppStorage("ParkedTime", store: UserDefaults(suiteName: "group.com.Parki.Parki")) var storedTime: Date = Date()

    @State private var action: Int?
    
    var body: some View {
        VStack {
            NavigationLink(destination: UpdateView(), tag: 0, selection: $action) { EmptyView() }
            
            Spacer().frame(height: 0.183 * UIScreen.screenHeight)
            
            LastModifiedTimeView(time: self.storedTime)
            Spacer().frame(height: 0.062 * UIScreen.screenHeight)
            
            WidgetView(floor: self.floor)
                .frame(width: 158, height: 158)
                .scaleEffect(1.5)
            Spacer().frame(height: 0.2 * UIScreen.screenHeight)
            
            Button { self.action = 0 } label: {
                MainBtn(label: "New Parking")
            }
            Spacer().frame(height: 0.142 * UIScreen.screenHeight)
            
            Icon()
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
        .background(Color.backgroundColor.ignoresSafeArea())
        .hiddenNavigationBarStyle()
    }
}

private struct LastModifiedTimeView: View {

    let time: Date
    
    var body: some View {
        HStack (spacing: 0.005 * UIScreen.screenWidth) {
            // for the icon
            Image("LastModified")
                .scaledToFit()
                .frame(width: 0.153 * UIScreen.screenWidth)
            // for the text
            VStack (alignment: .leading) {
                Text("\(getFormatDate(time: self.time))")
                    .font(.custom(Font.semiBold, size: 17))
                    .foregroundColor(.headerColor)
                Text("\(getFormatTime(time: self.time))")
                    .font(.custom(Font.semiBold, size: 17))
                    .foregroundColor(.headerColor)
            }
        }
        .padding(.leading, 0.056 * UIScreen.screenWidth)
        .frame(width: UIScreen.screenWidth, alignment: .leading)
    }
    
    func getFormatDate(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, E"
        let result = formatter.string(from: time)
        
        return result
    }
    
    func getFormatTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let result = formatter.string(from: time)
        
        return result
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
