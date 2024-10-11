//
//  CoinDetailsViewModel.swift
//  Crypto
//
//  Created by Mos on 10.10.24.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service = CoinDataService()
    private let coinId: String
    
    @Published var coinDetails: CoinDetails?
    
    init(coinId: String) {
        print("did init")
        self.coinId = coinId
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