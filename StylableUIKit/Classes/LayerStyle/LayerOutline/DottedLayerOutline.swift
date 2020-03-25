//
//  DashedLayerOutline.swift
//  StylableUIKit
//

import UIKit

public struct DashedLayerOutline: LayerOutline {
    let color: UIColor
    let width: Double
    let lineDashPattern: [NSNumber]

    public init(color: UIColor, width: Double, lineDashPattern: [NSNumber]) {
        self.color = color
        self.width = width
        self.lineDashPattern = lineDashPattern
    }

    public func draw(into view: UIView) {
        let stylableView = view.getLayerStylableView()

        let outline = ResizingCAShapeLayer()

        outline.fillColor = nil
        outline.strokeColor = self.color.cgColor
        outline.lineDashPattern = self.lineDashPattern
        outline.lineWidth = CGFloat(width)
        outline.frame = view.bounds
        outline.setNeedsDisplay()

        stylableView.layer.addSublayer(outline)
    }
}

final class ResizingCAShapeLayer: CAShapeLayer {

    required override init() {
        super.init()
        self.needsDisplayOnBoundsChange = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.needsDisplayOnBoundsChange = true
    }

    required override init(layer: Any) {
        super.init(layer: layer)
        self.needsDisplayOnBoundsChange = true
    }

    override func draw(in ctx: CGContext) {
        ctx.saveGState()

        let width = self.lineWidth
        let frame = CGRect(x: self.bounds.minX + (width / 2),
                           y: self.bounds.minY + (width / 2),
                           width: self.bounds.width - width,
                           height: self.bounds.height - width)

        let path = UIBezierPath(roundedRect: frame, cornerRadius: self.cornerRadius)
        path.close()

        self.path = path.cgPath
        super.draw(in: ctx)
        ctx.restoreGState()
    }
}
