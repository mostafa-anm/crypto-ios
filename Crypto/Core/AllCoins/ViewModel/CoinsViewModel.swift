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

    private let service: CoinDataService

    init(service: CoinDataService) {
        self.service = service
        Task { await fetchCoins() }
    }

    @MainActor
    func fetchCoins() async {
        do {
            coins = try await service.fetchCoins()
        } catch {
            if let error = error as? CoinAPIError {
                errorMessage = error.customDescription
            } else {
                errorMessage = error.localizedDescription
            }
        }
    }
}
