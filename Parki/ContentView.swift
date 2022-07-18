//
//  ContentView.swift
//  Parki
//
//  Created by Yi Qin on 7/17/22.
//

import SwiftUI

struct ContentView: View {
    
    // for default floors
    let options: [Int] = [4, 5, 6]
    @State var selectionStatus: [Bool]
    
    // for input floor
    @State var input: String = ""
    
    // for saving the results
    @State var source: Source = .fromSelection
    @State var result: Int = 0 // for storing the final selected floor num
    
    enum Source {
        case fromSelection
        case fromInput
    }
    
    init() {
        self.selectionStatus = Array(repeating: false, count: options.count)
    }
    
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                CurrentDateView()
                Spacer().frame(height: 0.067 * UIScreen.screenHeight)
                
                Group {
                    selections
                    Spacer().frame(height: 0.041 * UIScreen.screenHeight)
                    
                    inputView
                    Spacer().frame(height: 0.111 * UIScreen.screenHeight)
                    
                    confirmBtn
                }
                Spacer().frame(height: 0.142 * UIScreen.screenHeight)
            }
            
            HStack {
                Image("Icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 0.094 * UIScreen.screenWidth)
                    .padding(.trailing, 0.084 * UIScreen.screenWidth)
            }.frame(width: UIScreen.screenWidth, alignment: .trailing)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .background(Color.backgroundColor.ignoresSafeArea())
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
                            
                            // save the result from the selection
                            self.source = .fromSelection
                            self.result = options[i]
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
                    // change every btn in the selection to false
                    for j in 0..<self.selectionStatus.count {
                        self.selectionStatus[j] = false
                    }
                    self.source = .fromInput
                }
        }
    }
    
    var confirmBtn: some View {
        Button {
            save()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.primaryColor)
                    .frame(width: 0.825 * UIScreen.screenWidth, height: 0.059 * UIScreen.screenHeight)
                Text("Confirm")
                    .foregroundColor(.primaryTextColor)
                    .font(.custom(Font.semiBold, size: 20))
            }
        }
    }
    
    // save the result from the input field
    func save() {
        if self.source == .fromInput {
            self.result = Int(self.input) ?? 0
        }
        UserDefaults.standard.set(self.result, forKey: "ParkedFloor")
        // to be completed - guard empty input
    }
}

// Helper for getting the date
private struct CurrentDateView: View {
    // for getting current day
    let dateGetter = Date()
    let dateFormatter = DateFormatter()
    
    // for the date
    let date: String
    
    // for the weekday
    let weekDay: String
    
    init() {
        // for the date
        dateFormatter.dateFormat = "MMM d"
        self.date = dateFormatter.string(from: dateGetter)
        
        // for the weekday
        dateFormatter.dateFormat = "EEEE"
        self.weekDay = dateFormatter.string(from: dateGetter)
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
// styling for header
private struct Header: View {
    let text: String
    
    var body: some View {
        Text("\(text)")
            .foregroundColor(.headerColor)
            .font(.custom(Font.semiBold, size: 20))
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
