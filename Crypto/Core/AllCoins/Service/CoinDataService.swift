//
//  CoinDataService.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import Foundation

class CoinDataService: HTTPDataDownloader {

    func fetchCoins() async throws -> [Coin] {
        guard let endpoint = allCoinsURLString else {
            throw CoinAPIError.requestfailed(description: "Invalid URL")
        }
        return try await fetchData(as: [Coin].self, endpoint: endpoint)
    }

    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        guard let endpoint = coinDetailsURLString(id: id) else {
            throw CoinAPIError.requestfailed(description: "Invalid URL")
        }
        return try await fetchData(as: CoinDetails.self, endpoint: endpoint)
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
            .init(name: "per_page", value: "20"),
            .init(name: "page", value: "1"),
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
