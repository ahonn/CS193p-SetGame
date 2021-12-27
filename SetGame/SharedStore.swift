//
//  SharedStore.swift
//  SetGame
//
//  Created by Yuexun Jiang on 2021/12/23.
//

import Foundation

class SharedStore: ObservableObject {
    @Published private var setGameModel: SetGameModel = SetGameModel(deal: 12)
    
    var cardsOnTheTable: Array<Card> {
        return setGameModel.idOfCardOnTheTable.map { id in
            return setGameModel.cards.first(where: { $0.id == id })!
        }
    }
    
    var canDealing: Bool {
        cardsOnTheTable.count < 81
    }
    
    func toggleSelect(_ card: Card) {
        setGameModel.toggleSelect(card)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.setGameModel.checkSet()
        })
    }
    
    func dealCards() {
        setGameModel.deal(count: 3)
    }
    
    func replayGame() {
        setGameModel.replay()
    }
}
