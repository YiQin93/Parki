//
//  WidgetView.swift
//  Parki
//
//  Created by Yi Qin on 7/18/22.
//

import SwiftUI

struct WidgetView: View {
    
    let floor: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .top) {
//                 Use the followings to make the text scale based on widget size
//                .scaledToFit()
//                .lineLimit(1)
//                .minimumScaleFactor(0.5)
                
                Text("You parked at")
                    .font(.custom(Font.semiBold, size: 17))
                    .scaledToFit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.headerColor)
                    .padding(.top, 0.158 * geo.size.height)
                    .frame(width: 0.772 * geo.size.width)
                
                Text("\(self.floor)")
                    .font(.custom(Font.semiBold, size: 80))
                    .scaledToFit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.primaryColor)
                    .padding(.top, 0.259 * geo.size.height)
                    .frame(height: 0.85 * geo.size.width) // limit the size by height to ensure numbers with 2 digits can be properly displayed
                
                Text("floor")
                    .font(.custom(Font.regular, size: 15))
                    .scaledToFit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.secondaryTextColor)
                    .padding(.top, 0.791 * geo.size.height)
                    .frame(width: 0.215 * geo.size.width)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
        }
        .background(Color.backgroundColor)
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(floor: 1)
            .frame(width: 120, height: 120)
    }
}
