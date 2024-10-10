//
//  CoinDataService.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import Foundation

class CoinDataService {
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc"
    
    func fetchCoins() async throws -> [Coin] {
        guard let url = URL(string: urlString) else { return [] }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinAPIError.requestfailed(description: "request failed")
            
        }

        guard httpResponse.statusCode == 200 else {
            throw CoinAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }

        do {
            let coins = try JSONDecoder().decode([Coin].self, from: data)
            return coins
        } catch {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }

    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        let urlString = "https://api.coingecko.com/api/v3/coins/\(id)?localization=false"
        
        guard let url = URL(string: urlString) else { return nil }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinAPIError.requestfailed(description: "request failed")
            
        }

        guard httpResponse.statusCode == 200 else {
            throw CoinAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }

        do {
            let coinDetails = try JSONDecoder().decode(CoinDetails.self, from: data)
            return coinDetails
        } catch {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
}
