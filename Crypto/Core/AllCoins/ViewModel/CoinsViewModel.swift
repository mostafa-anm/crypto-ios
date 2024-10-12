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

    private let service: CoinDataServiceProtocol

    init(service: CoinDataServiceProtocol) {
        self.service = service
    }

    @MainActor
    func fetchCoins() async {
        do {
            let coins = try await service.fetchCoins()
            self.coins.append(contentsOf: coins)
        } catch {
            if let error = error as? CoinAPIError {
                errorMessage = error.customDescription
            } else {
                errorMessage = error.localizedDescription
            }
        }
    }
}
