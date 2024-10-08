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
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                Text("\(viewModel.coin): \(viewModel.price)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
