//
//  MockCoinService.swift
//  Crypto
//
//  Created by Mos on 11.10.24.
//

import Foundation

class MockCoinService: CoinDataServiceProtocol {
    var mockData: Data?
    var mockError: CoinAPIError?

    func fetchCoins() async throws -> [Coin] {
        if let mockError { throw mockError }

        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockData ?? mockCoinData_marketCapDesc)
            return coins
        } catch {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }

    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        let description = Description(text: "Test desc")
        return CoinDetails(id: "bitcoin", symbol: "btc", name: "BitCoin", description: description)
    }
}
