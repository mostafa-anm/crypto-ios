//
//  CoinDetailsView.swift
//  Crypto
//
//  Created by Mos on 10.10.24.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: Coin
    @ObservedObject var viewModel: CoinDetailsViewModel
    
    init(coin: Coin, service: CoinDataServiceProtocol) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coinId: coin.id, service: service)
    }

    var body: some View {
        VStack(alignment: .leading) {
            if let details = viewModel.coinDetails {
                HStack {
                    Text(details.name)
                        .fontWeight(.semibold)
                        .font(.subheadline)

                    Text(details.symbol.uppercased())
                        .font(.footnote)

                    Spacer()

                    CoinImageView(url: coin.image)
                        .frame(width:63, height: 64)
                }

                Text(details.description.text)
                    .font(.footnote)
                    .padding(.vertical)
            }
        }
        .task {
            await viewModel.fetchCoinDetails()
        }
        .padding()
    }
}

//#Preview {
//    CoinDetailsView()
//}
