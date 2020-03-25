//
//  LayerStyleTests.swift
//  StylableUIKit_Tests
//

import XCTest
import FBSnapshotTestCase

@testable import StylableUIKit

final class LayerStyleOutlineTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testViewRedFillAndBlackDash5Outline() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        let fill = FlatLayerFill(color: UIColor.red)
        let outline = DashedLayerOutline(color: UIColor.black, width: 2.0, lineDashPattern: [5, 5])
        let style = LayerStyle(fill: fill, outline: outline)
        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewRedFillAndBlackDash10And5Outline() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        let fill = FlatLayerFill(color: UIColor.red)
        let outline = DashedLayerOutline(color: UIColor.black, width: 2.0, lineDashPattern: [10, 5])
        let style = LayerStyle(fill: fill, outline: outline)
        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewRedFillAndBlueDashEmptyPatternOutline() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        let fill = FlatLayerFill(color: UIColor.red)
        let outline = DashedLayerOutline(color: UIColor.blue, width: 2.0, lineDashPattern: [])
        let style = LayerStyle(fill: fill, outline: outline)
        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewWithRadialGradientAndBlackDash10And5Outline() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let center = CGPoint(x: 0.5, y: 0.5)
        let fill = GradientLayerFill(colors: [.blue, .orange], style: .radial(center: center, locations: nil))
        let outline = DashedLayerOutline(color: UIColor.black, width: 2.0, lineDashPattern: [10, 5])
        let style = LayerStyle(fill: fill, outline: outline)
        style.apply(view)

        FBSnapshotVerifyView(view)
    }
}
