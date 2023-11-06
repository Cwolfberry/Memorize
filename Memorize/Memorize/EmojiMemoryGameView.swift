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
        /*
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
        .padding(.horizontal)*/
        
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
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
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5).opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
//                    .font(font(in: geometry.size))
                    .font(Font.system(size: DrawConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            //            .modifier(Cardify(isFaceUp: card.isFaceUp))
            .cardify(isFaceUp: card.isFaceUp)
        }
        
    }
    
    private func scale(thatFits size:CGSize) -> CGFloat {
        min(size.width, size.height) / ( DrawConstants.fontSize / DrawConstants.fontScale )
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawConstants.fontScale)
    }
    
    private struct DrawConstants {
//        static let cornerRadius: CGFloat = 10
//        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
}

#Preview {
    let game =  EmojiMemoryGame()
    game.choose(game.cards.first!)
    return EmojiMemoryGameView(game: game)
//        .preferredColorScheme(.light)
//    ContentView()
//        .preferredColorScheme(.dark)
}
