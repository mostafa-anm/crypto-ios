//
//  CoinImageView.swift
//  Crypto
//
//  Created by Mos on 12.10.24.
//

import SwiftUI

struct CoinImageView: View {
    @ObservedObject var imageLoader: ImageLoader

    init(url: String) {
        self.imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        if let image = imageLoader.image {
            image
                .resizable()
        }
    }
}

//#Preview {
//    CoinImageView()
//}
