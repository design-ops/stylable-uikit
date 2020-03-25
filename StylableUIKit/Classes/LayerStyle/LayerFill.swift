//
//  LayerFill.swift
//  StylableUIKit
//

import UIKit

// MARK: - LayerFill Implementations

public struct FlatLayerFill: LayerFill {

    let color: UIColor

    public init(color: UIColor) {
        self.color = color
    }

    public func draw<T: UIView>(into view: T) {
        view.getLayerStylableView().backgroundColor = self.color
    }

    public func getColor() -> UIColor? {
        return self.color
    }
}

/// GradientLayerFill
/// Creates a fill layer with a gradient of an array of colours.
/// Can have one of two styles: axial (e.g. left-to-right) or radial.
public struct GradientLayerFill: LayerFill {

    /// The style of the gradient
    public enum Style {
        case axial(direction: Direction, locations: [Double]?)
        case radial(center: CGPoint, locations: [Double]?)
    }

    /// The direction of an axial gradient layer. Both start and end must be between 0 and 1.
    public struct Direction {
        let start: CGPoint
        let end: CGPoint

        public static let leftToRight = Direction(start: .zero, end: CGPoint(x: 1.0, y: 0.0))
        public static let rightToLeft = Direction(start: CGPoint(x: 1.0, y: 0.0), end: .zero)
        public static let topToBottom = Direction(start: .zero, end: CGPoint(x: 0.0, y: 1.0))
        public static let bottomToTop = Direction(start: CGPoint(x: 0.0, y: 1.0), end: .zero)

        public init(start: CGPoint, end: CGPoint) {
            self.start = start
            self.end = end
        }
    }

    let colors: [UIColor]
    let style: Style

    public init(colors: [UIColor], style: Style) {
        self.colors = colors
        self.style = style
    }

    public func draw<T: UIView>(into view: T) {
        let stylableView = view.getLayerStylableView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = stylableView.bounds
        gradientLayer.colors = self.colors.map { $0.cgColor }
        switch style {
        case .axial(let direction, let locations):
            gradientLayer.startPoint = direction.start
            gradientLayer.endPoint = direction.end
            gradientLayer.locations = locations?.map { NSNumber(value: $0) }
            gradientLayer.type = .axial
        case .radial(let center, let locations):
            gradientLayer.startPoint = center
            gradientLayer.locations = locations?.map { NSNumber(value: $0) }
            gradientLayer.type = .radial
        }

        stylableView.layer.insertSublayer(gradientLayer, at: 0)
    }

    public func getColor() -> UIColor? {
        return colors.first
    }
}

public struct ImageLayerFill: LayerFill {

    let image: UIImage
    let resizingMode: UIImage.ResizingMode
    let gravity: CALayerContentsGravity

    public init(image: UIImage, resizingMode: UIImage.ResizingMode, gravity: CALayerContentsGravity = .resizeAspect) {
        self.image = image
        self.resizingMode = resizingMode
        self.gravity = gravity
    }

    public func draw<T: UIView>(into view: T) {
        let stylableView = view.getLayerStylableView()
        switch self.resizingMode {
        case .stretch:
            self.paintImageOnLayer(stylableView.layer)
        case .tile:
            self.tileImageOnView(stylableView)
        @unknown default:
            self.paintImageOnLayer(stylableView.layer)
        }
    }

    private func paintImageOnLayer(_ layer: CALayer) {
        layer.contents = self.image.cgImage
        layer.contentsGravity = self.gravity
    }

    private func tileImageOnView(_ view: UIView) {
        let color = UIColor(patternImage: self.image)
        let fill = FlatLayerFill(color: color)
        fill.draw(into: view)
    }

    public func getColor() -> UIColor? {
        return nil
    }
}

// MARK: - LayerStylableViewProvider
/// Because some views can't be background styled directly

@objc public protocol LayerStylableViewProvider {
    @objc func getLayerStylableView() -> UIView
}

extension UITableViewCell {
    override open func getLayerStylableView() -> UIView {
        guard let backgroundView = self.backgroundView else {
            let newView = UIView(frame: self.bounds)
            self.backgroundView = newView
            return newView
        }
        return backgroundView
    }
}

extension UITableView {
    override open func getLayerStylableView() -> UIView {
        guard let backgroundView = self.backgroundView else {
            let newView = UIView(frame: self.bounds)
            self.backgroundView = newView
            return newView
        }
        return backgroundView
    }
}

extension UIView: LayerStylableViewProvider {
    open func getLayerStylableView() -> UIView { return self }
}
