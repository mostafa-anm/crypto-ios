//
//  CryptoTests.swift
//  CryptoTests
//
//  Created by Mos on 11.10.24.
//

import XCTest
@testable import Crypto

final class CryptoTests: XCTestCase {

    func test_decodedCoinsIntoArray_marketCapDesc() throws {
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockCoinData_marketCapDesc)
            XCTAssertEqual(coins.count, 20) // ensures all coins were decoded
            XCTAssertEqual(coins, coins.sorted(by: { $0.marketCapRank < $1.marketCapRank })) // enusre sorting order
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
