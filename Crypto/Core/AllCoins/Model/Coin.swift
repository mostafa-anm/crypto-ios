//
//  Coin.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import Foundation

struct Coin: Decodable, Identifiable, Hashable {
    let id: String
    let symbol: String
    let name: String
    let currentPrice: Double
    let marketCapRank: Int


    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
    }
}
