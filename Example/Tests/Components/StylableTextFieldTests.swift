//
//  StylableTextFieldTests.swift
//  StylableUIKit_Tests
//

import XCTest
import FBSnapshotTestCase

@testable import StylableUIKit

final class StylableTextFieldTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testTextFieldStyling() {
        let textField = StylableTextField(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let style = TextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red)
        textField.setTextStyle(style)

        textField.text = "Text for the test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(textField)

        FBSnapshotVerifyView(textField)
    }

    func testTextFieldStylingWithBasicTextStyle() {
        let textField = StylableTextField(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let style = BasicTextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red)
        textField.setTextStyle(style)

        textField.text = "Text for the test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(textField)

        FBSnapshotVerifyView(textField)
    }

    func testTextFieldStylingWithDifferentTextAlignments() {
        let textField = StylableTextField(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 50)))
        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)
        layerStyle.apply(textField)

        textField.text = "Text for the test"

        let centerStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                         textColor: .orange,
                                         backgroundColor: .blue,
                                         lineSpacing: 2,
                                         letterSpacing: 2,
                                         textAlignment: .center,
                                         variantType: UIControl.State.normal)

        textField.setTextStyle(centerStyle)

        FBSnapshotVerifyView(textField, identifier: "center")

        let rightStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                        textColor: .orange,
                                        backgroundColor: .blue,
                                        lineSpacing: 2,
                                        letterSpacing: 2,
                                        textAlignment: .right,
                                        variantType: UIControl.State.normal)

        textField.setTextStyle(rightStyle)

        FBSnapshotVerifyView(textField, identifier: "right")

        let leftStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                       textColor: .orange,
                                       backgroundColor: .blue,
                                       lineSpacing: 2,
                                       letterSpacing: 2,
                                       textAlignment: .left,
                                       variantType: UIControl.State.normal)

        textField.setTextStyle(leftStyle)

        FBSnapshotVerifyView(textField, identifier: "left")
    }

    func testTextFieldStylingWithDifferentTextTransforms() {
        let textField = StylableTextField(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 50)))
        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)
        layerStyle.apply(textField)

        textField.text = "Text for the test"

        let lowStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                      textColor: .orange,
                                      backgroundColor: .blue,
                                      lineSpacing: 2,
                                      letterSpacing: 2,
                                      textAlignment: .center,
                                      textTransform: .lowercased,
                                      variantType: UIControl.State.normal)

        textField.setTextStyle(lowStyle)

        FBSnapshotVerifyView(textField, identifier: "lowercased")

        let upStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                     textColor: .orange,
                                     backgroundColor: .blue,
                                     lineSpacing: 2,
                                     letterSpacing: 2,
                                     textAlignment: .center,
                                     textTransform: .uppercased,
                                     variantType: UIControl.State.normal)

        textField.setTextStyle(upStyle)

        FBSnapshotVerifyView(textField, identifier: "uppercased")

        let capStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                      textColor: .orange,
                                      backgroundColor: .blue,
                                      lineSpacing: 2,
                                      letterSpacing: 2,
                                      textAlignment: .center,
                                      textTransform: .capitalized,
                                      variantType: UIControl.State.normal)

        textField.setTextStyle(capStyle)

        FBSnapshotVerifyView(textField, identifier: "capitalized")
    }

    func testTextFieldStylingWithBasicPlaceholderTextStyle() {
        let textField = StylableTextField(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let style = BasicTextStyle(font: .boldSystemFont(ofSize: 20), textColor: .blue)
        textField.setPlaceholderTextStyle(style)

        textField.placeholder = "Text for the test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(textField)

        FBSnapshotVerifyView(textField, identifier: "placeholder")
    }
}
