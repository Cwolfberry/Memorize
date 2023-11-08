//
//  Cardify.swift
//  Memorize
//
//  Created by avalan.zhang on 2023/11/1.
//

/**
  Only changes can be animated. Changes to what?
  1 . ViewModifier arguments
  2.   Shapes
  3.  The "existence"( or not) of a View in the UI
 */


import SwiftUI

struct Cardify: AnimatableModifier {
//    var isFaceUp: Bool
    
    init(isFaceUp: Bool) {
//        self.isFaceUp = isFaceUp
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawConstants.lineWidth) // stroke:向外延伸 | strokeBorder:向内延伸
            }
            else {
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    
    private struct DrawConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
