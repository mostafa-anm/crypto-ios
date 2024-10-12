//
//  CoinDataService.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import Foundation

protocol CoinDataServiceProtocol {
    func fetchCoins() async throws -> [Coin]
    func fetchCoinDetails(id: String) async throws -> CoinDetails?
}

class CoinDataService: CoinDataServiceProtocol, HTTPDataDownloader {

    private var page = 0
    private var fetchLimit = 30

    func fetchCoins() async throws -> [Coin] {
        page += 1

        guard let endpoint = allCoinsURLString else {
            throw CoinAPIError.requestfailed(description: "Invalid URL")
        }

        return try await fetchData(as: [Coin].self, endpoint: endpoint)
    }

    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        if let cachedCoinDetails = CoinDetailsCache.shared.get(forkey: id) {
            return cachedCoinDetails
        }

        guard let endpoint = coinDetailsURLString(id: id) else {
            throw CoinAPIError.requestfailed(description: "Invalid URL")
        }

        let coinDetails = try await fetchData(as: CoinDetails.self, endpoint: endpoint)
        CoinDetailsCache.shared.set(coinDetails, forKey: id)

        return coinDetails
    }

    private var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins/"

        return components
    }

    private var allCoinsURLString: String? {
        var components = baseURLComponents
        components.path += "markets"

        components.queryItems = [
            .init(name: "vs_currency", value: "usd"),
            .init(name: "order", value: "market_cap_desc"),
            .init(name: "per_page", value: "\(fetchLimit)"),
            .init(name: "page", value: "\(page)"),
            .init(name: "price_change_percentage", value: "24h")
        ]

        return components.url?.absoluteString
    }

    private func coinDetailsURLString(id: String) -> String? {
        var components = baseURLComponents
        components.path += "\(id)"
        components.queryItems = [
            .init(name: "localization", value: "false")
        ]

        return components.url?.absoluteString
    }
}
