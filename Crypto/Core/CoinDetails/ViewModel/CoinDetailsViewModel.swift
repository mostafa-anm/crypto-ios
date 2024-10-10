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
//        try? await Task.sleep(nanoseconds: 2_000_000_000)
        do {
            let details = try await service.fetchCoinDetails(id: coinId)
            print("DEBUG: details \(details!.id)")
            coinDetails = details
        } catch {
            print("DEBUG: prob in fetching coin details")
        }
    }
}
