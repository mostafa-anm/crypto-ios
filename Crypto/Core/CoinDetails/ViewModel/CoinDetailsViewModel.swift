//
//  CoinDetailsViewModel.swift
//  Crypto
//
//  Created by Mos on 10.10.24.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service: CoinDataServiceProtocol
    private let coinId: String
    
    @Published var coinDetails: CoinDetails?
    
    init(coinId: String, service: CoinDataServiceProtocol) {
        self.coinId = coinId
        self.service = service
//        Task { await fetchCoinDetails() }
    }
    
    @MainActor
    func fetchCoinDetails() async {
        do {
            coinDetails = try await service.fetchCoinDetails(id: coinId)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}
