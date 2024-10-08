//
//  CoinDataService.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import Foundation

class CoinDataService {
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc"

    func fetchCoins(completion: @escaping(Result<[Coin], Error>) -> Void ) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else {
                print("wrong decoding")
                return
            }

            completion(.success(coins))
        }.resume()
    }
}
