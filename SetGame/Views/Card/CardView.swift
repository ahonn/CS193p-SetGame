//
//  CardView.swift
//  SetGame (iOS)
//
//  Created by Yuexun Jiang on 2021/12/23.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var background: some View {
        ZStack(alignment: .center, content:{
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill().foregroundColor(Color.white).opacity(0.5)
            shape.strokeBorder(lineWidth: 2).opacity(0.75)
        })
    }
    
    var selection: some View {
        ZStack(alignment: .center, content: {
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill().foregroundColor(.black).opacity(0.2)
        })
    }
    
    var body: some View {
        ZStack(alignment: .center, content: {
            background
            CardContent(card: card).padding(.all)
            if card.isSelected {
                selection
            }
        })
        .padding(5)
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(id: UUID(), numberOfShape: 3, shape: CardShape.diamond, shading: CardShading.soild, color: CardColor.red))
        CardView(card: Card(id: UUID(), numberOfShape: 3, shape: CardShape.squiggle, shading: CardShading.striped, color: CardColor.green))
        CardView(card: Card(id: UUID(), numberOfShape: 3, shape: CardShape.oval, shading: CardShading.open, color: CardColor.purple))
        CardView(card: Card(id: UUID(), numberOfShape: 3, shape: CardShape.oval, shading: CardShading.soild, color: CardColor.purple, isSelected: true))
    }
}
