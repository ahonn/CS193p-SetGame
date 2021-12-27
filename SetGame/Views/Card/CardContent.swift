//
//  CardSymbol.swift
//  SetGame (iOS)
//
//  Created by Yuexun Jiang on 2021/12/23.
//

import SwiftUI

struct CardContent: View {
    let card: Card;
    
    private var color: Color {
        switch card.color {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }
    
    var shape: some View {
        Group {
            switch card.shape {
            case .diamond: renderShading() { DiamondShape() }
            case .squiggle: renderShading() { SquiggleShape() }
            case .oval: renderShading() { OvalShape() }
            }
        }
    }
    
    var body: some View {
            GeometryReader { geometry in
                VStack {
                    ForEach(0..<card.numberOfShape) { _ in
                        shape.frame(width: geometry.size.width, height: geometry.size.height / 4, alignment: .center)
                    }
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .foregroundColor(color)
            }
    }
    
    private func renderShading<ContentView: Shape>(@ViewBuilder for content: @escaping () -> ContentView) -> some View {
        ZStack {
            Group {
                switch (card.shading) {
                case .open: EmptyView()
                case .striped: VStripeShape().clipShape(content())
                case .soild: content()
            }
            }
            content().stroke(lineWidth: 2)
        }
    }
}

struct CardSymbol_Previews: PreviewProvider {
    static var previews: some View {
        CardContent(card: Card(id: UUID(), numberOfShape: 3, shape: CardShape.diamond, shading: CardShading.soild, color: CardColor.red))
        CardContent(card: Card(id: UUID(), numberOfShape: 3, shape: CardShape.squiggle, shading: CardShading.striped, color: CardColor.green))
        CardContent(card: Card(id: UUID(), numberOfShape: 3, shape: CardShape.oval, shading: CardShading.open, color: CardColor.purple))
    }
}
 
