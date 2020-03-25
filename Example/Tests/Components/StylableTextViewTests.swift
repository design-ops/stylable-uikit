//
//  StylableTextViewTests.swift
//  StylableUIKit_Tests
//

import XCTest
import FBSnapshotTestCase

@testable import StylableUIKit

final class StylableTextViewTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testStylingTextView() {
        let view = StylableTextView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let style = TextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red)
        view.setTextStyle(style)

        view.text = "Text for the test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testStylingTextVieWithBasicTextStyle() {
        let view = StylableTextView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let style = BasicTextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red)
        view.setTextStyle(style)

        view.text = "Text for the test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testTextFieldStylingWithDifferentTextAlignments() {
        let textView = StylableTextView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 50)))
        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)
        layerStyle.apply(textView)

        textView.text = "Text for the test"

        let centerStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                         textColor: .orange,
                                         backgroundColor: .blue,
                                         lineSpacing: 2,
                                         letterSpacing: 2,
                                         textAlignment: .center,
                                         variantType: UIControl.State.normal)

        textView.setTextStyle(centerStyle)

        FBSnapshotVerifyView(textView, identifier: "center")

        let rightStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                        textColor: .orange,
                                        backgroundColor: .blue,
                                        lineSpacing: 2,
                                        letterSpacing: 2,
                                        textAlignment: .right,
                                        variantType: UIControl.State.normal)

        textView.setTextStyle(rightStyle)

        FBSnapshotVerifyView(textView, identifier: "right")

        let leftStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                       textColor: .orange,
                                       backgroundColor: .blue,
                                       lineSpacing: 2,
                                       letterSpacing: 2,
                                       textAlignment: .left,
                                       variantType: UIControl.State.normal)

        textView.setTextStyle(leftStyle)

        FBSnapshotVerifyView(textView, identifier: "left")
    }

    func testTextFieldStylingWithDifferentTextTransforms() {
        let textView = StylableTextView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 50)))
        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)
        layerStyle.apply(textView)

        textView.text = "Text for the test"

        let lowStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                         textColor: .orange,
                                         backgroundColor: .blue,
                                         lineSpacing: 2,
                                         letterSpacing: 2,
                                         textAlignment: .center,
                                         textTransform: .lowercased,
                                         variantType: UIControl.State.normal)

        textView.setTextStyle(lowStyle)

        FBSnapshotVerifyView(textView, identifier: "lowercased")

        let upStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                        textColor: .orange,
                                        backgroundColor: .blue,
                                        lineSpacing: 2,
                                        letterSpacing: 2,
                                        textAlignment: .center,
                                        textTransform: .uppercased,
                                        variantType: UIControl.State.normal)

        textView.setTextStyle(upStyle)

        FBSnapshotVerifyView(textView, identifier: "uppercased")

        let capStyle = BasicTextStyle(font: .boldSystemFont(ofSize: 12),
                                       textColor: .orange,
                                       backgroundColor: .blue,
                                       lineSpacing: 2,
                                       letterSpacing: 2,
                                       textAlignment: .center,
                                       textTransform: .capitalized,
                                       variantType: UIControl.State.normal)

        textView.setTextStyle(capStyle)

        FBSnapshotVerifyView(textView, identifier: "capitalized")
    }
}
