//
//  StylableLabelTests.swift
//  StylableUIKit_Tests
//

import XCTest
import FBSnapshotTestCase

@testable import StylableUIKit

final class StylableLabelTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testStylingLabel() {
        let label = StylableLabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))

        let style = TextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red)
        label.setTextStyle(style)
        label.text = "This is a test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(label)

        FBSnapshotVerifyView(label)
    }

    func testStylingLabelWithRightAlignment() {
        let label = StylableLabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))

        let style = TextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red, textAlignment: .right)
        label.setTextStyle(style)
        label.text = "This is a test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(label)

        FBSnapshotVerifyView(label)
    }

    func testStylistLabelWithCenterAlignment() {
        let label = StylableLabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))

        let style = TextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red, textAlignment: .center)
        label.setTextStyle(style)
        label.text = "This is a test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(label)

        FBSnapshotVerifyView(label)
    }

    func testStylingLabelWithBasicTextStyle() {
        let label = StylableLabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))

        let style = BasicTextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red)
        label.setTextStyle(style)
        label.text = "This is a test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(label)

        FBSnapshotVerifyView(label)
    }

    func testStylingLabelWithUppercasedTextTransform() {
        let label = StylableLabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))

        let style = BasicTextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red, textTransform: .uppercased)
        label.setTextStyle(style)
        label.text = "This is a test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(label)

        FBSnapshotVerifyView(label)
    }

    func testStylingLabelWithLowercasedTextTransform() {
        let label = StylableLabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))

        let style = BasicTextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red, textTransform: .lowercased)
        label.setTextStyle(style)
        label.text = "This is a test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(label)

        FBSnapshotVerifyView(label)
    }

    func testStylingLabelWithCapitalizedTextTransform() {
        let label = StylableLabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))

        let style = BasicTextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red, textTransform: .capitalized)
        label.setTextStyle(style)
        label.text = "This is a test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(label)

        FBSnapshotVerifyView(label)
    }

    func testStylingLabelWithNoneTextTransform() {
        let label = StylableLabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))

        let style = BasicTextStyle(font: .boldSystemFont(ofSize: 12), textColor: .red, textTransform: .none)
        label.setTextStyle(style)
        label.text = "This is a test"

        let fill = FlatLayerFill(color: .yellow)
        let layerStyle = LayerStyle(fill: fill, outline: nil)

        layerStyle.apply(label)

        FBSnapshotVerifyView(label)
    }
}

/*
 let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))
 label.font = .boldSystemFont(ofSize: 12)
 label.textColor = .red
 label.textAlignment = .center
 label.backgroundColor = .yellow
 label.text = "This is a test"
*/
