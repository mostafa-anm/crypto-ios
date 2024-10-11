//
//  CoinDataService.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import Foundation

class CoinDataService: HTTPDataDownloader {
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc"

    func fetchCoins() async throws -> [Coin] {
        return try await fetchData(as: [Coin].self, endpoint: urlString)
    }

    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        let urlString = "https://api.coingecko.com/api/v3/coins/\(id)?localization=false"
        return try await fetchData(as: CoinDetails.self, endpoint: urlString)
    }
}
