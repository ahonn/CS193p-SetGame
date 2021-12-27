//
//  DiamondShape.swift
//  SetGame
//
//  Created by Yuexun Jiang on 2021/12/23.
//

import SwiftUI

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addLines([
            CGPoint(x: rect.width / 2, y: 0),
            CGPoint(x: 0, y: rect.height / 2),
            CGPoint(x: rect.width / 2, y: rect.height),
            CGPoint(x: rect.width, y: rect.height / 2),
            CGPoint(x: rect.width / 2, y: 0),
        ])
        return p
    }
}
