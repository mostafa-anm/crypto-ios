//
//  MockCoinService.swift
//  Crypto
//
//  Created by Mos on 11.10.24.
//

import Foundation

class MockCoinService: CoinDataServiceProtocol {
    func fetchCoins() async throws -> [Coin] {
        let bitcoin = Coin(id: "bitcoin", symbol: "btc", name: "Bitcoin", currentPrice: 70000, marketCapRank: 1)
        return [bitcoin]
    }

    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        let description = Description(text: "Test desc")
        return CoinDetails(id: "bitcoin", symbol: "btc", name: "BitCoin", description: description)
    }
}
