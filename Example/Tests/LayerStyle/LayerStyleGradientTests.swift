//
//  LayerStyleTests.swift
//  StylableUIKit_Tests
//

import XCTest
import FBSnapshotTestCase

@testable import StylableUIKit

final class LayerStyleGradientTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testViewWithAxialGradientTopToBottom() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let fill = GradientLayerFill(colors: [.blue, .orange], style: .axial(direction: .topToBottom, locations: nil))
        let style = LayerStyle(fill: fill)

        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewWithRadialGradient() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let center = CGPoint(x: 0.5, y: 0.5)
        let fill = GradientLayerFill(colors: [.blue, .orange], style: .radial(center: center, locations: nil))
        let style = LayerStyle(fill: fill)
        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewWithGradientAppliedManyTimes() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let color1 = UIColor.red.withAlphaComponent(0.1)
        let color2 = UIColor.green.withAlphaComponent(0.1)

        let fill = GradientLayerFill(colors: [color1, color2], style: .axial(direction: .topToBottom, locations: nil))

        let style = LayerStyle(fill: fill)

        for _ in 0 ..< 50 {
            style.apply(view)
        }

        FBSnapshotVerifyView(view)
    }

    func testViewWithAlphaChannel() {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        let fill = FlatLayerFill(color: UIColor(white: 1, alpha: 0.5))
        let style = LayerStyle(fill: fill, outline: nil)

        style.apply(view)

        FBSnapshotVerifyView(view)
    }

}
