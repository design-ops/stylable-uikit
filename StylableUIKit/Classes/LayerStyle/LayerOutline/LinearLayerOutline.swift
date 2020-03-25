//
//  LinearLayerOutline.swift
//  StylableUIKit
//

import UIKit

public struct LinearLayerOutline: LayerOutline {
    let color: UIColor
    let width: Double

    public init(color: UIColor, width: Double) {
        self.color = color
        self.width = width
    }

    public func draw(into view: UIView) {
        let stylableView = view.getLayerStylableView()
        stylableView.layerBorderColor = color
        stylableView.layerBorderWidth = NSNumber(value: width)
    }
}

// MARK: - Exposed CALayer properties
/// Create dynamic properties for UIView to enable use of Appearance Proxy
fileprivate extension UIView {

    @objc dynamic var layerBackgroundColor: UIColor? {
        get {
            guard let cgColor = self.layer.backgroundColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { self.layer.backgroundColor = newValue?.cgColor }
    }

    @objc dynamic var layerBorderColor: UIColor? {
        get {
            guard let cgColor = self.layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { self.layer.borderColor = newValue?.cgColor }
    }

    @objc dynamic var layerBorderWidth: NSNumber {
        get { return NSNumber(value: Float(self.layer.borderWidth)) }
        set { self.layer.borderWidth = CGFloat(newValue.doubleValue) }
    }
}
