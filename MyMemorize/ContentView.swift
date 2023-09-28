//
//  ContentView.swift
//  MyMemorize
//
//  Created by Zhansen Zhalel on 28.09.2023.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = [String]()
    
    let vehicles = ["🚗", "🏎", "🚓", "🛞", "🏎", "🛞", "🚗", "🚓"]
    let food = ["🍎", "🍕", "🍗", "🍪", "🥐", "🍕", "🍔", "🍎", "🍪", "🍔", "🍗", "🥐"]
    let animals = ["🐶", "🐯", "🐶", "🐥", "🐴", "🐧", "🦊", "🐥", "🐼", "🐴", "🐰", "🐰", "🐼", "🦊", "🐯", "🐧"]
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeChangeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        // and I don't know how to change cards' color
        .foregroundColor(.red)
    }
    
    func buttonStyleChange(on title: String, symbol: String) -> some View {
        VStack {
            Image(systemName: symbol).font(.title)
            Text(title)
        }
        .imageScale(.large)
    }
    
    var themeChangeButtons: some View {
        HStack(alignment: .bottom) {
            Spacer()
            // this code smells
            Button(action: {
                emojis = vehicles.shuffled()
            }, label: {
                buttonStyleChange(on: "Vehicles", symbol: "car.fill")
            })
            
            Spacer()
            
            Button(action: {
                emojis = food.shuffled()
            }, label: {
                buttonStyleChange(on: "Food", symbol: "fork.knife")
            })
            
            Spacer()
            
            Button(action: {
                emojis = animals.shuffled()
            }, label: {
                buttonStyleChange(on: "Animals", symbol: "swift")
            })
            
            Spacer()
        }
    }
}

struct CardView: View {
    var content: String
    
    @State var isFaceUp = false

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            base.fill(.red).opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
