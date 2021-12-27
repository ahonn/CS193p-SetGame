//
//  SetGameApp.swift
//  Shared
//
//  Created by Yuexun Jiang on 2021/12/22.
//

import SwiftUI

@main
struct SetGameApp: App {
    let store = SharedStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
