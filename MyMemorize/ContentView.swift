//
//  ContentView.swift
//  MyMemorize
//
//  Created by Zhansen Zhalel on 28.09.2023.
//

import SwiftUI

struct ContentView: View {
    let cars = ["🚗", "🏎", "🚓", "🛞", "🚗", "🏎", "🚓", "🛞"]
    
    @State var cardCount = 1
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(emoji: cars[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.red)
    }
    
    func cardCountAdjusting(by offset: Int, sign: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: "\(sign).rectangle.portrait.fill")
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > 8)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cardAdder: some View {
        cardCountAdjusting(by: +1, sign: "plus")
        
    }
    
    var cardRemover: some View {
        cardCountAdjusting(by: -1, sign: "minus")
        
    }
}

struct CardView: View {
    var emoji: String
    
    @State var isFaceUp = true

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(emoji).font(.largeTitle)
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
