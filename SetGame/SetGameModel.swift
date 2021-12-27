//
//  SetGameModel.swift
//  SetGame
//
//  Created by Yuexun Jiang on 2021/12/22.
//

import Foundation

enum CardColor {
    case red
    case green
    case purple
}

enum CardShading {
    case soild
    case striped
    case open
}

enum CardShape {
    case diamond
    case squiggle
    case oval
}

struct Card: Identifiable {
    var id: UUID
    var numberOfShape: Int
    var shape: CardShape
    var shading: CardShading
    var color: CardColor
    var isSet: Bool = false
    var isSelected: Bool = false
}

struct SetGameModel {
    private(set) var cards: Array<Card>
    var idOfCardOnTheTable: Array<UUID>
    
    private var idOfTheSelectedCards: Array<UUID> {
        cards
            .filter { !$0.isSet && $0.isSelected }
            .map { $0.id }
    }
    
    static private func getShuffledCards() -> [Card] {
        var cards = Array<Card>();
        for number in 1...3 {
            for shape in [CardShape.diamond, CardShape.squiggle, CardShape.oval] {
                for shading in [CardShading.soild, CardShading.striped, CardShading.open] {
                    for color in [CardColor.red, CardColor.green, CardColor.purple] {
                        cards.append(Card(id: UUID(), numberOfShape: number, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        return cards.shuffled()
    }
    
    static private func openingDeal(cards: [Card], numberOfDeal: Int) -> [UUID] {
        var ids = Array<UUID>()
        for _ in 0..<numberOfDeal {
            var randomIndex = Int.random(in: 0..<cards.count)
            while ids.contains(cards[randomIndex].id) {
                randomIndex = (randomIndex + 1) % cards.count
            }
            ids.append(cards[randomIndex].id)
        }
        return ids
    }
    
    init(deal: Int) {
        cards = SetGameModel.getShuffledCards()
        idOfCardOnTheTable = SetGameModel.openingDeal(cards: cards, numberOfDeal: 12)
    }
    
    private func canSetBy<T: Hashable>(_ getter: (Card) -> T) -> Bool {
        var set = Set<T>()
        for id in idOfTheSelectedCards {
            if let card = cards.first(where: { $0.id == id }) {
                set.insert(getter(card))
            }
        }
        return set.count == 1 || set.count == 3
    }
    
    mutating func toggleSelect(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isSelected = !cards[index].isSelected
        }
    }
    
    mutating func checkSet() {
        if idOfTheSelectedCards.count < 3 {
            return
        }
        
        if canSetBy({ $0.numberOfShape }) && canSetBy({ $0.shape }) && canSetBy({ $0.shading }) && canSetBy({ $0.color }) {
            for id in idOfTheSelectedCards {
                if let index = cards.firstIndex(where: { $0.id == id }) {
                    cards[index].isSet = true
                    cards[index].isSelected = false
                    
                    if let indexOfTable = idOfCardOnTheTable.firstIndex(where: { $0 == id }) {
                        idOfCardOnTheTable.remove(at: indexOfTable)
                    }
                }
            }
            let count = 12 - idOfCardOnTheTable.count
            deal(count: count)
        } else {
            for id in idOfTheSelectedCards {
                if let index = cards.firstIndex(where: { $0.id == id }) {
                    cards[index].isSelected = false
                }
            }
        }
    }
    
    mutating func deal(count: Int) {
        for _ in 0..<count {
            var randomIndex = Int.random(in: 0..<cards.count)
            while (idOfCardOnTheTable.contains(cards[randomIndex].id) || cards[randomIndex].isSet) {
                randomIndex = (randomIndex + 1) % cards.count
            }
            idOfCardOnTheTable.append(cards[randomIndex].id)
        }
    }
    
    mutating func replay() {
        cards = SetGameModel.getShuffledCards()
        idOfCardOnTheTable = SetGameModel.openingDeal(cards: cards, numberOfDeal: 12)
    }
}
