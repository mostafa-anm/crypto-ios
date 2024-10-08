//
//  CoinsViewModel.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var errorMessage: String?

    private let service = CoinDataService()

    init() {
        fetchCoins()
    }

    func fetchCoins() {
        service.fetchCoins { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self.coins = coins
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
