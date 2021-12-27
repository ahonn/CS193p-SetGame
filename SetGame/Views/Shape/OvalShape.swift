//
//  OvalShape.swift
//  SetGame
//
//  Created by Yuexun Jiang on 2021/12/23.
//

import SwiftUI

struct OvalShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addEllipse(in: rect)
        return p
    }
}
