//
//  Pie.swift
//  Memorize
//
//  Created by avalan.zhang on 2023/11/1.
//

import SwiftUI

// Shape 可以进行动画， View不可以
struct Pie : Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    // rect: 父View的frame
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius*CGFloat(cos(startAngle.radians)),
            y: center.y + radius*CGFloat(sin(startAngle.radians))
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        p.addLine(to: center)
        
        return p
    }
    
}
