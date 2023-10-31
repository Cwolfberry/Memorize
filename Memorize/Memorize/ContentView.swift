//
//  ContentView.swift
//  Memorize
//
//  Created by avalan.zhang on 2023/10/30.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        ScrollView {
            // [GridItem(), GridItem(), GridItem()] :  固定三行
            // [GridItem(.adaptive(minimum: 65))] : 最小宽度为65，根据屏幕（横向、竖向）自适应显示的item数量
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }

}

struct CardView : View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3) // stroke:向外延伸 | strokeBorder:向内延伸
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
    }
}

#Preview {
    ContentView(viewModel: EmojiMemoryGame())
//        .preferredColorScheme(.light)
//    ContentView()
//        .preferredColorScheme(.dark)
}
