//
//  ContentView.swift
//  Shared
//
//  Created by Yuexun Jiang on 2021/12/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: SharedStore
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
             Text("Set Game").font(.title)
             AspectVGrid(items: store.cardsOnTheTable, aspectRatio: 2/3, maxColumnCount: 6, content: { card in
                CardView(card: card)
                    .onTapGesture {
                        store.toggleSelect(card)
                    }
            })
            .padding([.top, .leading, .trailing])
            HStack {
                Button("New Game", action: {
                    store.replayGame()
                })
                .padding(.all)
                Spacer()
                Button("Deal More", action: {
                    store.dealCards()
                })
                .disabled(!store.canDealing)
                .padding(.all)
            }
            .padding(.horizontal)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = SharedStore()
        ContentView(store: store)
    }
}

