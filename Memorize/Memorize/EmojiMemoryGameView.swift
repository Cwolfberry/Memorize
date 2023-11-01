//
//  ContentView.swift
//  Memorize
//
//  Created by avalan.zhang on 2023/10/30.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        
        ScrollView {
            // [GridItem(), GridItem(), GridItem()] :  固定三行
            // [GridItem(.adaptive(minimum: 65))] : 最小宽度为65，根据屏幕（横向、竖向）自适应显示的item数量
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(game.cards) { card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }

}

struct CardView : View {
    private let card: EmojiMemoryGame.Card
    
    init(_ givenCard: EmojiMemoryGame.Card) {
        self.card = givenCard
    }
    
    var body: some View {
        // GeometryReader也是一种View, 可以知道当前View所占用的空间大小
        GeometryReader (content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawConstants.lineWidth) // stroke:向外延伸 | strokeBorder:向内延伸
                    Text(card.content)
//                        .font(.largeTitle)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.fill()
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawConstants.fontScale)
    }
    
    private struct DrawConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}

#Preview {
    EmojiMemoryGameView(game: EmojiMemoryGame())
//        .preferredColorScheme(.light)
//    ContentView()
//        .preferredColorScheme(.dark)
}
