//
//  ContentView.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import SwiftUI

struct ContentView: View {
    private let service: CoinDataServiceProtocol

    @StateObject var viewModel: CoinsViewModel

    init(service: CoinDataServiceProtocol) {
        self.service = service
        self._viewModel = StateObject(wrappedValue: CoinsViewModel(service: service))
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.coins) { coin in
                        NavigationLink(value: coin) {
                            HStack(spacing: 12) {
                                Text("\(coin.marketCapRank)")
                                    .foregroundColor(.gray)

                                AsyncImage(url: URL(string: coin.image)) { image in
                                    image.resizable().frame(width: 32, height:32)
                                } placeholder: {
                                    EmptyView()
                                }


                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(coin.name)")
                                        .fontWeight(.semibold)

                                    Text("\(coin.symbol.uppercased())")
                                }
                            }
                            .onAppear {
                                if coin == viewModel.coins.last {
                                    print("DEBUG: last coin appeared \(coin.name)")
                                    Task { await viewModel.fetchCoins() }
                                }
                            }
                            .font(.footnote)
                        }
                    }
                }
                .navigationDestination(for: Coin.self, destination: { coin in
                    CoinDetailsView(coin: coin, service: service)
                })
                .overlay {
                    if let error = viewModel.errorMessage {
                        Text(error)
                    }
                }
            }
            .padding()
        }
        .task {
            await viewModel.fetchCoins()
        }
    }
}

#Preview {
    ContentView(service: MockCoinService())
}
