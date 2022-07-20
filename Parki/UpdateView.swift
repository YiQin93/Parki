//
//  UpdateView.swift
//  Parki
//
//  Created by Yi Qin on 7/18/22.
//

import SwiftUI
import WidgetKit

struct UpdateView: View {
    // for default floors
    let options: [Int]
    @State var selectionStatus: [Bool]
    @State var selection: Int = 0 // the selected floor
    
    // for input floor
    @State var input: String = ""
    
    // for saving the results
    @State var source: Source = .fromSelection
    @AppStorage("ParkedFloor", store: UserDefaults(suiteName: "group.com.Parki.Parki")) var parkedFloor: Int = 0 // for storing the final selected floor num
    @AppStorage("ParkedTime", store: UserDefaults(suiteName: "group.com.Parki.Parki")) var updateTime: Date = Date() // for storing the time for this update
    
    enum Source {
        case fromSelection
        case fromInput
    }
    
    // for navigating to the next view
    @State private var action: Int?
    // for navigating back from its descendents views
    @Environment(\.presentationMode) var presentationMode
    
    init(options: [Int] = [4, 5, 6]) {
        self.options = options
        _selectionStatus = State(initialValue: Array(repeating: false, count: options.count))
    }
    
    var body: some View {
        VStack {
            
            NavigationLink(destination: DisplayView(), tag: 0, selection: $action) { EmptyView() }
            
            VStack (alignment: .leading) {
                Spacer().frame(height: 0.05 * UIScreen.screenHeight)
                
                CurrentDateView()
                Spacer().frame(height: 0.067 * UIScreen.screenHeight)
                
                Group {
                    selections
                    Spacer().frame(height: 0.041 * UIScreen.screenHeight)
                    
                    inputView
                    Spacer().frame(height: 0.05 * UIScreen.screenHeight) // 0.111
                    
                    confirmBtn
                    Spacer().frame(height: 0.022 * UIScreen.screenHeight)
                }
            }
            // for the cancel btn
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("cancel")
                    .font(.custom(Font.regular, size: 15))
                    .foregroundColor(.secondaryTextColor.opacity(0.8))
            }.frame(height: 0.052 * UIScreen.screenHeight)
            Spacer().frame(height: 0.1 * UIScreen.screenHeight)
            
            Icon()
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .background(Color.backgroundColor.ignoresSafeArea())
        .hiddenNavigationBarStyle()
    }
    
    
    
    var selections: some View {
        VStack (alignment: .leading) {
            // for the header
            Header(text: "Select the floor")
            Spacer().frame(height: 0.021 * UIScreen.screenHeight)
            
            // for the btns
            HStack (spacing: 0.061 * UIScreen.screenWidth) {
                // for the default floors
                ForEach(0..<options.count, id: \.self) { i in
                    Selection(floorNum: options[i], selected: selectionStatus[i])
                        .onTapGesture {
                            // change every other btns to false
                            for j in 0..<self.selectionStatus.count {
                                if j != i {
                                    self.selectionStatus[j] = false
                                }
                            }
                            // toggle the chosen btn
                            self.selectionStatus[i].toggle()
                            
                            self.cleanInput() // clear the input field
                            
                            self.source = .fromSelection // update the source indicator
                            self.selection = options[i] // save the result from the selection
                        }
                }
            }
        }
    }

    var inputView: some View {
        VStack (alignment: .leading) {
            Header(text: "or")
            Spacer().frame(height: 0.03 * UIScreen.screenHeight)
                
            InputField(text: $input, textHint: "Enter a floor")
                .onChange(of: input) { newValue in
                    self.cleanSelection() // clean the selections
                    self.source = .fromInput // update the source indicator
                }
        }
    }
    
    var confirmBtn: some View {
        Button {
            save()
            self.action = 0
        } label: {
            MainBtn(label: "Confirm")
        }
    }
    
    
    func save() {
        // save the result from the input field
        switch source {
        case .fromInput:
            self.parkedFloor = Int(self.input) ?? 0
        case .fromSelection:
            self.parkedFloor = self.selection
        }
        // save the current time
        self.updateTime = Date()
        
        // enable timely update on the widget
        WidgetCenter.shared.reloadTimelines(ofKind: "Parki_Widget")
        
        // to be completed - guard empty input
    }
    
    // Helper functions for making selections and inputing floor num
    // clean the selections
    func cleanSelection() {
        // change every btn in the selection to false
        for j in 0..<self.selectionStatus.count {
            self.selectionStatus[j] = false
        }
    }
    // clean the input field
    func cleanInput() {
        self.input = ""
    }
}


// Helper for getting the date
private struct CurrentDateView: View {
    // for getting current day
    let dateGetter = Date()
    let formatter = DateFormatter()
    
    // for the date
    let date: String
    
    // for the weekday
    let weekDay: String
    
    init() {
        // for the date
        formatter.dateFormat = "MMM d"
        self.date = formatter.string(from: dateGetter)
        
        // for the weekday
        formatter.dateFormat = "EEEE"
        self.weekDay = formatter.string(from: dateGetter)
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(self.weekDay)")
                .foregroundColor(.headerColor)
                .font(.custom(Font.regular, size: 17))
            Text("\(self.date)")
                .foregroundColor(.headerColor)
                .font(.custom(Font.regular, size: 17))
        }
    }
}



// helper for selecting floor
private struct Selection: View {
    
    let floorNum: Int
    let selected: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 0.23 * UIScreen.screenWidth, height: 0.152 * UIScreen.screenHeight)
                .foregroundColor(selected ? .primaryColor : .secondaryColor)
                .shadow(color: selected ? .dropShadowColor : .clear, radius: 40, x: 0, y: 10)
            Text("\(floorNum)")
                .font(.custom(Font.regular, size: 40))
                .foregroundColor(selected ? .primaryTextColor : .secondaryTextColor)
        }
    }
}

// helper for inputing floor
private struct InputField: View {
    
    @Binding var text: String
    let textHint: String // the default display when input is empty
    
    let width: Double = 0.825 * UIScreen.screenWidth
    let height: Double = 0.082 * UIScreen.screenHeight
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .font(.custom(Font.semiBold, size: 20))
                .foregroundColor(.secondaryTextColor)
                .padding()
                .modifier(PlaceholderStyle(showPlaceHolder: text.isEmpty,
                                           placeholder: "Enter a floor"))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.secondaryColor))
                .frame(width: width, height: height)
                .keyboardType(.numberPad)
        }
    }
}

// for input field placeholder to have custom color
struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .font(.custom(Font.semiBold, size: 20))
                    .foregroundColor(.secondaryTextColor)
                    .padding(.horizontal, 15)
            }
            content
                .foregroundColor(.secondaryTextColor)
        }
    }
}


struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}
