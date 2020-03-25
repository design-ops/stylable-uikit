//
//  LayerStyleTests.swift
//  StylableUIKit_Tests
//

import XCTest
import FBSnapshotTestCase

@testable import StylableUIKit

final class LayerStyleImageTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testViewWithImageStretched() {
        let image = UIImage(named: "cut-icon", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 100)))
        let fill = ImageLayerFill(image: image, resizingMode: .stretch)

        let style = LayerStyle(fill: fill)
        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewWithImageStretchedWithResize() {
        let image = UIImage(named: "cut-icon", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 100)))
        let fill = ImageLayerFill(image: image, resizingMode: .stretch, gravity: .resize)

        let style = LayerStyle(fill: fill)
        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewWithImageStretchedWithResizeAspect() {
        let image = UIImage(named: "cut-icon", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 100)))
        let fill = ImageLayerFill(image: image, resizingMode: .stretch, gravity: .resizeAspect)

        let style = LayerStyle(fill: fill)
        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewWithImageStretchedWithResizeAspectFill() {
        let image = UIImage(named: "cut-icon", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 100)))
        let fill = ImageLayerFill(image: image, resizingMode: .stretch, gravity: .resizeAspectFill)

        let style = LayerStyle(fill: fill)
        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewWithImageTiled() {
        let image = UIImage(named: "cut-icon", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let smallerImage = self.resizeImage(image, to: CGSize(width: 20, height: 20))
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        let fill = ImageLayerFill(image: smallerImage, resizingMode: .tile)

        let style = LayerStyle(fill: fill)
        style.apply(view)

        FBSnapshotVerifyView(view)
    }

    func testViewWithImageAppliedManyTimes() {
        // image being loaded has transparency, so using a container with a blue background to prove the transparency is respected
        let image = UIImage(named: "bw-gradient-50perc-trans", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let containerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        containerView.backgroundColor = .blue
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        let fill = ImageLayerFill(image: image, resizingMode: .stretch)

        let style = LayerStyle(fill: fill)
        //style.apply(view)

        for _ in 0 ..< 50 {
            style.apply(view)
        }

        containerView.addSubview(view)
        FBSnapshotVerifyView(containerView)
    }

    private func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
