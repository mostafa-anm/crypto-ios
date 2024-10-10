//
//  CoinAPIError.swift
//  Crypto
//
//  Created by Mos on 09.10.24.
//

import Foundation

enum CoinAPIError: Error {
    case invalidData
    case jsonParsingFailure
    case requestfailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)

    var customDescription: String {
        switch self {
        case .invalidData: return "Invalid data"
        case .jsonParsingFailure: return "Failed to parse JSON"
        case let .requestfailed(description): return "Request failed: \(description)"
        case let .invalidStatusCode(statusCode): return "Invalid status code: \(statusCode)"
        case let .unknownError(error): return "An unknow error occured: \(error.localizedDescription)"
        }
    }
}
