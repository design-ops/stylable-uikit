//
//  AssetTests.swift
//  StylableUIKit_Tests
//

import XCTest

@testable import StylableUIKit

final class AssetTests: XCTestCase {

    func testReturningVariantsOnAsset() {
        let selectedAsset = BasicAsset(image: UIImage(), variantType: UIControl.State.selected)
        let disabledAsset = BasicAsset(image: UIImage(), variantType: UIControl.State.disabled)
        let normalAsset = Asset(image: UIImage(), variants: [selectedAsset, disabledAsset])

        XCTAssertNotNil(normalAsset.variant(UIControl.State.selected))
        XCTAssertTrue(normalAsset.variant(UIControl.State.selected)?.variantType.name == selectedAsset.variantType.name)
        XCTAssertNotNil(normalAsset.variant(UIControl.State.disabled))
        XCTAssertTrue(normalAsset.variant(UIControl.State.disabled)?.variantType.name == disabledAsset.variantType.name)
        XCTAssertTrue(normalAsset.variant(UIControl.State.focused) == nil)
    }

    func testVariantReturnsSelfOnAsset() {
        let normalAsset = Asset(image: UIImage(), variants: [])

        XCTAssertTrue(normalAsset.variantType.name == UIControl.State.normal.name)
        XCTAssertTrue(normalAsset.variantType.name == normalAsset.variant(UIControl.State.normal)!.variantType.name)
    }

}
