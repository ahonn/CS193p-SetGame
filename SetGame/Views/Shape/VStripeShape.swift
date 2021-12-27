//
//  HStripeShape.swift
//  SetGame (iOS)
//
//  Created by Yuexun Jiang on 2021/12/28.
//

import SwiftUI

struct VStripeShape: Shape {
    var stripeSize: CGFloat?
    
    func path(in rect: CGRect) -> Path {
        let stripe = stripeSize ?? defaultStripeSize
        let realStripeSize = (stripe < minStripeSize) ? minStripeSize : stripe
        let intervalSize = realStripeSize * stripeSpaceRatio
        let numberOfLines = Int(floor(rect.width / intervalSize))

        var p = Path()
        for i in (0...numberOfLines) {
            let startX = rect.minX + CGFloat(CGFloat(i) * intervalSize)
            let endX = realStripeSize + startX
            
            p.move(to: CGPoint(x: startX, y: rect.minY))
            p.addLine(to: CGPoint(x: endX, y: rect.minY))
            p.addLine(to: CGPoint(x: endX, y: rect.maxY))
            p.addLine(to: CGPoint(x: startX, y: rect.maxY))
            p.closeSubpath()
        }
        return p
    }
    
    private let minStripeSize: CGFloat = 0.1
    private let defaultStripeSize: CGFloat = 1.0
    private let stripeSpaceRatio: CGFloat = 5.0
}

struct VStripeShape_Previews: PreviewProvider {
    static var previews: some View {
        VStripeShape()
    }
}
