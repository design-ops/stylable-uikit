//
//  LayerStyleTests.swift
//  StylableUIKit_Tests
//

import XCTest
import FBSnapshotTestCase

@testable import StylableUIKit

final class LayerStyleTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testViewWithRedFill() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let fill = FlatLayerFill(color: .red)
        let style = LayerStyle(fill: fill, outline: nil)

        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewWithRedFillGreenOutline() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let fill = FlatLayerFill(color: .red)
        let outline = LinearLayerOutline(color: .green, width: 2.0)
        let style = LayerStyle(fill: fill, outline: outline)

        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewWithBasicFillAndOutlineThatResizes() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))

        let fill = FlatLayerFill(color: .red)
        let outline = LinearLayerOutline(color: .green, width: 2.0)
        let style = LayerStyle(fill: fill, outline: outline)

        style.apply(view)

        view.frame.size = CGSize(width: 100, height: 100)

        FBSnapshotVerifyView(view)
    }

}
