//
//  MemorizeApp.swift
//  Memorize
//
//  Created by avalan.zhang on 2023/10/30.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
