//
//  CoinsViewModelTests.swift
//  CryptoTests
//
//  Created by Mos on 11.10.24.
//

import XCTest
@testable import Crypto

final class CoinsViewModelTests: XCTestCase {
    func testInit() {
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        XCTAssertNotNil(viewModel)
    }

    func testSuccessfullCoinsFetch() async {
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()
        XCTAssertTrue(viewModel.coins.count == 20)
        XCTAssertEqual(viewModel.coins.count, 20) // ensures all coins were decoded
        XCTAssertEqual(viewModel.coins, viewModel.coins.sorted(by: { $0.marketCapRank < $1.marketCapRank })) // enusre sorting order
    }

    func testCoinFetchWithInvalidJSON() async {
        let service = MockCoinService()
        service.mockData = mockCoins_invalidJSON

        let viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()

        XCTAssertTrue(viewModel.coins.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func testThrowsInvalidDataError() async {
        let service = MockCoinService()
        service.mockError = CoinAPIError.invalidData

        let viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()

        XCTAssertEqual(viewModel.errorMessage, CoinAPIError.invalidData.customDescription)
    }

    func testThrowsInvalidSattusCode() async {
        let service = MockCoinService()
        service.mockError = CoinAPIError.invalidStatusCode(statusCode: 404)

        let viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()

        XCTAssertEqual(viewModel.errorMessage, CoinAPIError.invalidStatusCode(statusCode: 404).customDescription)
    }
}
