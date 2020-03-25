//
//  LayerStyleRoundedCornerTests.swift
//  StylableUIKit_Tests
//

import XCTest
import FBSnapshotTestCase

@testable import StylableUIKit

class LayerStyleRoundedCornerTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func viewWithOutline(_ outline: LayerOutline) -> (UIView, UIView) {
        let view = UIView(frame: CGRect(origin: CGPoint(x: 20, y: 20), size: CGSize(width: 100, height: 100)))
        let fill = FlatLayerFill(color: UIColor.green)
        let style = LayerStyle(fill: fill, outline: outline)
        view.layer.cornerRadius = 20.0
        view.layer.masksToBounds = true
        style.apply(view)
        //
        let container =  UIView(frame: CGRect(origin: .zero, size: CGSize(width: 140, height: 140)))
        container.backgroundColor = .white
        container.addSubview(view)
        return (container, view)
    }

    func testLinearOutlineWithRoundedCorners() {
        let outline = LinearLayerOutline(color: UIColor.black, width: 2.0)
        let (view, _) = viewWithOutline(outline)

        FBSnapshotVerifyView(view)
    }

    func testDottedOutlineWithRoundedCorners() {
        let outline = DashedLayerOutline(color: UIColor.black, width: 2.0, lineDashPattern: [5, 5])
        let (view, _) = viewWithOutline(outline)

        FBSnapshotVerifyView(view)
    }

    func testResizingLinearOutlineWithRoundedCorners() {
        let outline = LinearLayerOutline(color: UIColor.black, width: 2.0)
        let (container, view) = viewWithOutline(outline)

        view.frame = CGRect(x: 10, y: 10, width: 120, height: 120)

        FBSnapshotVerifyView(container)
    }

    func testResizingDottedOutlineWithRoundedCorners() {
        let outline = DashedLayerOutline(color: UIColor.black, width: 2.0, lineDashPattern: [5, 5])
        let (container, view) = viewWithOutline(outline)

        view.frame = CGRect(x: 10, y: 10, width: 120, height: 120)

        FBSnapshotVerifyView(container)
    }

    func testResizingALoadOfDottedOutlineWithRoundedCorners() {
        // There is a bug / issue with using UIBezierPath(roundedRect:cornerRadius:)
        // as after a point it decides to just draw a circle instead of the specified shape
        // as that's not causing any in-the-wild issues, this can be a future bug fix, but this test is here to highlight it.

        let prefs: [CGFloat] = [10.0, 20.0, 30.0, 31.0, 32.0, 33.0, 35.0, 40.0, 45.0, 50.0, 60.0, 70.0]
        let views: [UIView] = prefs.map { cornerRadius in
            let view = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100)))
            let style = LayerStyle(fill: FlatLayerFill(color: UIColor.red),
                                   outline: DashedLayerOutline(color: UIColor.black, width: 2.0, lineDashPattern: [5, 5]))
            view.layer.cornerRadius = cornerRadius
            let label = UILabel(frame: CGRect(x: 30, y: 30, width: 40, height: 20))
            label.text = "\(cornerRadius)"
            view.addSubview(label)
            style.apply(view)
            return view
        }

        let container =  UIView(frame: CGRect(origin: .zero, size: CGSize(width: 40 + (110 * views.count), height: 140)))
        container.backgroundColor = .white

        for (index, view) in views.enumerated() {
            view.frame.origin.x = 20 + (CGFloat(integerLiteral: index) * 110)
            view.frame.origin.y = 20
            container.addSubview(view)
        }

        FBSnapshotVerifyView(container)
    }

}
