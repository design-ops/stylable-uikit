//
//  LayerStyle.swift
//  StylableUIKit
//

import UIKit

// MARK: - Layer Style protocols & core types
public enum DefaultLayerStyle: String, StylistLayerStyle {
    case background
}

public protocol LayerFill {
    func draw<T: UIView>(into view: T)
    func getColor() -> UIColor?
}

public protocol LayerOutline {
    func draw(into view: UIView)
}

// MARK: - LayerStyle implementation

/**
 Collection of attributes to apply to views
 */
public final class LayerStyle: BasicLayerStyle, VariantStyleProvider {
    public func variant(_ variant: StylistVariant) -> BasicLayerStyle? {
        return self.getVariant(variant, from: self.variants)
    }

    public func variantOrDefault(_ variant: StylistVariant) -> BasicLayerStyle {
        return self.variant(variant) ?? self
    }

    private var variants: [BasicLayerStyle] = []

    public init(fill: LayerFill,
                outline: LayerOutline? = nil,
                variantType: StylistVariant = UIControl.State.normal,
                variants: [BasicLayerStyle] = []) {
        super.init(fill: fill,
                   outline: outline,
                   variantType: variantType)
        self.variants = variants
    }
}

public class BasicLayerStyle: VariantStyle {

    private let fill: LayerFill
    private let outline: LayerOutline?
    public private(set) var variantType: StylistVariant = UIControl.State.normal

    public init(fill: LayerFill,
                outline: LayerOutline? = nil,
                variantType: StylistVariant = UIControl.State.normal) {
        self.fill = fill
        self.outline = outline
        self.variantType = variantType
    }

    public func apply<T: UIView>(_ view: T?) {
        guard let view = view else { return }

        // Create a Subview to contain LayerStyle CALayers
        let subview: UIView = {
            let realView = view.getLayerStylableView()
            var subview = realView.subviews.filter { return $0 is LayerResizingView }.first
            if subview == nil {
                subview = LayerResizingView(frame: realView.bounds)
                realView.addSubview(subview!)
                realView.sendSubviewToBack(subview!)
            }
            return subview!
        }()

        // clear existing layers to prevent cumulative layer build up
        subview.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        switch T.self {
        case is RestrictedLayerStylable.Type:
            if let color = fill.getColor() {
                // although swift knows that view is of type RestrictedLayerStylable
                // we can't cast to that type, but we *can* use objc to do it for us
                view.perform(#selector(RestrictedLayerStylable.setBackground(color:)), with: color)
            }
        default:
            self.fill.draw(into: subview)
        }
        self.outline?.draw(into: subview)

    }

    public func getColor() -> UIColor? {
        return self.fill.getColor()
    }
}

private final class LayerResizingView: UIView {

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.isUserInteractionEnabled = false

        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.translatesAutoresizingMaskIntoConstraints = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.superview?.layer.cornerRadius ?? 0
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        let previousAnimationDuration = CATransaction.animationDuration()
        CATransaction.setAnimationDuration(0.0)
        layer.sublayers?.forEach {
            $0.frame = layer.bounds
            $0.cornerRadius = self.superview?.layer.cornerRadius ?? 0
            $0.setNeedsDisplay()
        }
        CATransaction.setAnimationDuration(previousAnimationDuration)
    }
}
