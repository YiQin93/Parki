//
//  ContentView.swift
//  Parki
//
//  Created by Yi Qin on 7/17/22.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        NavigationView {
            DisplayView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
