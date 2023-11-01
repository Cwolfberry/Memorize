//
//  MemoryGame.swift
//  Memorize
//
//  Created by avalan.zhang on 2023/10/31.
//

import Foundation

// where CardContent: Equatable -> 限定CardContent的类型，必须是可以比较的
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    // 计算属性
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            /*
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            } else {
                return nil
            }*/
            cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
        }
        
        set {
            /*
            for index in cards.indices {
                if index != newValue {
                    cards[index].isFaceUp = false
                } else {
                    cards[index].isFaceUp = true
                }
            }*/
            cards.indices.forEach({ cards[$0].isFaceUp = ($0 == newValue)})
        }
    }
    
    // mutating: 修改整个struct的值
    mutating func choose(_ card: Card){
        // version 1
//        if let chosenIndex = index(of: card) {
//            cards[chosenIndex].isFaceUp.toggle()
//        }
//        var chosenCard = cards[chosenIndex]
        
        // version 2
//        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
//            cards[chosenIndex].isFaceUp.toggle()
//        }
        
        
        // version 3
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
//        print("\(cards)")
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
//        cards = Array<Card>()
        cards = []
        // add numberOfPairsOfCards*2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

// MARK: -
extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
