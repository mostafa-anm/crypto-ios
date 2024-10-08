//
//  CoinsViewModel.swift
//  Crypto
//
//  Created by Mos on 08.10.24.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coin = ""
    @Published var price = ""
    @Published var errorMessage: String?

    init() {
        fetchPrice(coin: "litecoin")
    }

    func fetchPrice(coin: String) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    self.errorMessage = "Response is not HTTPResponse"
                    return
                }

                guard response.statusCode == 200 else {
                    self.errorMessage = "Response is \(response.statusCode)"
                    return
                }

                guard let data = data else { return }
                guard let jsonObject =
                        try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                guard let value = jsonObject[coin] as? [String: Double] else { return }

                guard let price = value["usd"] else {return }

                self.coin = coin.capitalized
                self.price = "$\(price)"
            }
        }.resume()
    }
}
