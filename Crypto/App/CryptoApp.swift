//
//  CryptoApp.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import SwiftUI

@main
struct CryptoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(service: CoinDataService())
        }
    }
}
