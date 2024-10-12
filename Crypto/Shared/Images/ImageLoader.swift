//
//  ImageLoader.swift
//  Crypto
//
//  Created by Mos on 12.10.24.
//

import SwiftUI

class ImageLoader: ObservableObject {

    @Published var image: Image?
    private let urlString: String

    init(url: String) {
        self.urlString = url
        Task { await loadImage() }
    }

    @MainActor
    func loadImage() async {
        if let cached = ImageCache.shared.get(forkey: urlString) {
            self.image = Image(uiImage: cached)
            return
        }

        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: data) else { return }
            ImageCache.shared.set(uiImage, forKey: urlString)
            self.image = Image(uiImage: uiImage)
        } catch {
            print("DEBUG: Failed to fetch image \(error.localizedDescription)")
        }
    }
}
