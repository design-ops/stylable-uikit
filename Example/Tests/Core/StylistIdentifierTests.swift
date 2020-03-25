//
//  StylistIdentifierTests.swift
//  StylableUIKit_Tests
//

import XCTest

@testable import StylableUIKit

final class StylistIdentifierTests: XCTestCase {

    func testEquality() {
        let asset1 = MockStylistAsset(name: "Test")
        let asset2 = MockStylistAsset(name: "Test")
        let identifier1 = EquatableStylistIdentifier(asset1)
        let identifier2 = EquatableStylistIdentifier(asset2)

        XCTAssertTrue(identifier1 == identifier2)
    }
}
