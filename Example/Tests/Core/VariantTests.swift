//
//  VariantTests.swift
//  StylableUIKit_Tests
//

import XCTest

@testable import StylableUIKit

final class VariantTests: XCTestCase {

    func testReturningVariantsOnAsset() {
        let selected = BasicAsset(image: UIImage(), variantType: UIControl.State.selected)
        let disabled = BasicAsset(image: UIImage(), variantType: UIControl.State.disabled)
        let normal = Asset(image: UIImage(), variantType: UIControl.State.normal, variants: [selected, disabled])

        XCTAssertNotNil(normal.variant(UIControl.State.selected))
        XCTAssertTrue(normal.variant(UIControl.State.selected)?.variantType.name == selected.variantType.name)
        XCTAssertNotNil(normal.variant(UIControl.State.disabled))
        XCTAssertTrue(normal.variant(UIControl.State.disabled)?.variantType.name == disabled.variantType.name)
        XCTAssertTrue(normal.variant(UIControl.State.focused) == nil)

        XCTAssertTrue(normal.variantOrDefault(UIControl.State.selected).variantType.name == selected.variantType.name)
        XCTAssertTrue(normal.variantOrDefault(UIControl.State.disabled).variantType.name == disabled.variantType.name)
        XCTAssertTrue(normal.variantOrDefault(UIControl.State.focused).variantType.name == normal.variantType.name)
    }

    func testReturningVariantsOnTextStyle() {
        let selected = BasicTextStyle(font: UIFont.systemFont(ofSize: 12), textColor: .red, variantType: UIControl.State.selected)
        let disabled = BasicTextStyle(font: UIFont.systemFont(ofSize: 10), textColor: .darkGray, variantType: UIControl.State.disabled)
        let normal = TextStyle(font: UIFont.systemFont(ofSize: 12), textColor: .black, variants: [selected, disabled])

        XCTAssertNotNil(normal.variant(UIControl.State.selected))
        XCTAssertTrue(normal.variant(UIControl.State.selected)?.variantType.name == selected.variantType.name)
        XCTAssertNotNil(normal.variant(UIControl.State.disabled))
        XCTAssertTrue(normal.variant(UIControl.State.disabled)?.variantType.name == disabled.variantType.name)
        XCTAssertTrue(normal.variant(UIControl.State.focused) == nil)

        XCTAssertTrue(normal.variantOrDefault(UIControl.State.selected).variantType.name == selected.variantType.name)
        XCTAssertTrue(normal.variantOrDefault(UIControl.State.disabled).variantType.name == disabled.variantType.name)
        XCTAssertTrue(normal.variantOrDefault(UIControl.State.focused).variantType.name == normal.variantType.name)
    }

    func testReturningVariantsOnLayerStyle() {
        let selected = BasicLayerStyle(fill: FlatLayerFill(color: .yellow), variantType: UIControl.State.selected)
        let disabled = BasicLayerStyle(fill: FlatLayerFill(color: .lightGray), variantType: UIControl.State.disabled)
        let normal = LayerStyle(fill: FlatLayerFill(color: .white), variants: [selected, disabled])

        XCTAssertNotNil(normal.variant(UIControl.State.selected))
        XCTAssertTrue(normal.variant(UIControl.State.selected)?.variantType.name == selected.variantType.name)
        XCTAssertNotNil(normal.variant(UIControl.State.disabled))
        XCTAssertTrue(normal.variant(UIControl.State.disabled)?.variantType.name == disabled.variantType.name)
        XCTAssertTrue(normal.variant(UIControl.State.focused) == nil)
        //
        XCTAssertTrue(normal.variantOrDefault(UIControl.State.selected).variantType.name == selected.variantType.name)
        XCTAssertTrue(normal.variantOrDefault(UIControl.State.disabled).variantType.name == disabled.variantType.name)
        XCTAssertTrue(normal.variantOrDefault(UIControl.State.focused).variantType.name == normal.variantType.name)
    }
}
