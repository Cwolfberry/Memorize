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

class EmojiMemoryGame {
    
    static let emojis = ["🚕", "🛺", "🚔", "🚂", "🚗", "🚎", "🏎️", "🚓",
                             "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🚍",
                           "🚘", "🚖", "🚟", "🚃", "🚋", "🚝", "🚆", "🚇"]
    
    static func createMemoryGame() -> MemoryGame<String> {
//        MemoryGame(numberOfPairsOfCards: 4, createCardContent: makeCardContent)
        MemoryGame(numberOfPairsOfCards: 4, createCardContent: { pairIndex in
            emojis[pairIndex]
        })
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    
}
