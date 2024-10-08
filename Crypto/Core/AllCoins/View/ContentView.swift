//
//  ContentView.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.coins) { coin in
                    HStack(spacing: 12) {
                        Text("\(coin.marketCapRank)")
                            .foregroundColor(.gray)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(coin.name)")
                                .fontWeight(.semibold)

                            Text("\(coin.symbol.uppercased())")
                        }
                    }
                    .font(.footnote)
                }
            }
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
