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
            
            // for the time elapsed
            Text("\(getTimeElapsed(startTime: self.storedTime))")
            
            WidgetView(floor: self.floor)
                .frame(width: 158, height: 158)
                .scaleEffect(1.5)
            Spacer().frame(height: 0.214 * UIScreen.screenHeight)
            
            Button { self.action = 0 } label: {
                MainBtn(label: "Update Floor")
            }
            Spacer().frame(height: 0.142 * UIScreen.screenHeight)
            
            Icon()
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .background(Color.backgroundColor.ignoresSafeArea())
        .hiddenNavigationBarStyle()
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
