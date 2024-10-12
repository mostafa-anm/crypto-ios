//
//  ImageCache.swift
//  Crypto
//
//  Created by Mos on 12.10.24.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()

    let cache = NSCache<NSString, UIImage>()

    private init() {}

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func get(forkey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
