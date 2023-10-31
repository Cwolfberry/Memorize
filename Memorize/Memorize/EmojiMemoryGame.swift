//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by avalan.zhang on 2023/10/31.
//

import SwiftUI

func makeCardContent(index: Int) -> String {
    return "😃"
}

// MVVM
/**
    View --> ViewModel --> Model  :
    View <-- ViewModel 
    用户点击View，View持有ViewModel，View修改ViewModel中的数据， 同时View在监听ViewModel中的数据变化，如有变化，即刷新View自身
 */
class EmojiMemoryGame : ObservableObject {
    
    static let emojis = ["🚕", "🛺", "🚔", "🚂", "🚗", "🚎", "🏎️", "🚓",
                             "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🚍",
                           "🚘", "🚖", "🚟", "🚃", "🚋", "🚝", "🚆", "🚇"]
    
    static func createMemoryGame() -> MemoryGame<String> {
//        MemoryGame(numberOfPairsOfCards: 4, createCardContent: makeCardContent)
        MemoryGame(numberOfPairsOfCards: 4, createCardContent: { pairIndex in
            emojis[pairIndex]
        })
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
//        objectWillChange.send()
        model.choose(card)
//        print("viewmodel: choose...")
    }
    
    
}
