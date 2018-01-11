//
//  PurchaseCheckUseCaseTests.swift
//  Telephone
//
//  Copyright © 2008-2016 Alexey Kuznetsov
//  Copyright © 2016-2018 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import UseCases
import UseCasesTestDoubles
import XCTest

final class PurchaseCheckUseCaseTests: XCTestCase {
    func testCallsDidCheckPurchaseWhenReceiptIsValid() {
        let output = PurchaseCheckUseCaseOutputSpy()
        let expiration = Date()
        let sut = PurchaseCheckUseCase(receipt: ValidReceipt(expiration: expiration), output: output)

        sut.execute()

        XCTAssertTrue(output.didCallDidCheckPurchase)
        XCTAssertEqual(output.invokedExpiration, expiration)
    }

    func testCallsDidFailCheckingPurchaseWhenReceiptIsInvalid() {
        let output = PurchaseCheckUseCaseOutputSpy()
        let sut = PurchaseCheckUseCase(receipt: InvalidReceipt(), output: output)

        sut.execute()

        XCTAssertTrue(output.didCallDidFailCheckingPurchase)
    }

    func testCallsDidFailCheckingPurchaseWhenThereAreNoActivePurchases() {
        let output = PurchaseCheckUseCaseOutputSpy()
        let sut = PurchaseCheckUseCase(receipt: NoActivePurchasesReceipt(), output: output)

        sut.execute()

        XCTAssertTrue(output.didCallDidFailCheckingPurchase)
    }
}
