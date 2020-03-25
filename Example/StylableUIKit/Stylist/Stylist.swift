//
//  Stylist.swift
//  Stylable-UIKit_Example
//

import Foundation
import StylableUIKit

class AppStylist: Stylist {

    func asset(_ identifier: StylistAsset, element: StylistElement?, section: StylistSection?) -> Asset? {
        return nil
    }

    func animatedAsset(_ identifier: StylistAsset, element: StylistElement?, section: StylistSection?) -> StylistAnimatedAsset? {
        return identifier.name.asLottieAnimationView()
    }

    func textStyle(_ style: StylistTextStyle, element: StylistElement?, section: StylistSection?) -> TextStyle {
        var size: CGFloat = 10
        var color = UIColor.black

        if (style as? TextType) == TextType.primaryText {
            size = (element as? Element) == Element.secondaryButton ? 12 : 14
        }
        if (style as? TextType) == TextType.primaryText && (element as? Element) == Element.secondaryButton {
            size = 12
        }

        if (style as? TextType) == TextType.secondaryText && (element as? Element) == Element.textField {
            size = 12
            color = .red
        }

        if (style as? TextType) == TextType.primaryText && (element as? Element) == Element.textField {
            size = 12
            color = .blue
        }

        return TextStyle(font: .systemFont(ofSize: size), textColor: color)
    }

    func layerStyle(_ style: StylistLayerStyle, element: StylistElement?, section: StylistSection?) -> LayerStyle {

        if let element = element as? Element {
            switch element {
            case .label, .textField, .textView:
                return LayerStyle(fill: GradientLayerFill(colors: [.darkGray, .green], style: .radial(center: CGPoint(x: 0.25, y: 0.25), locations: nil)),
                                  outline: DashedLayerOutline(color: .white, width: 2, lineDashPattern: [2, 2]))
            case .primaryButton:
                return LayerStyle(fill: FlatLayerFill(color: .green), outline: DashedLayerOutline(color: .red, width: 2, lineDashPattern: [3, 3]))
            case .secondaryButton:
                return LayerStyle(fill: FlatLayerFill(color: .yellow), outline: LinearLayerOutline(color: .blue, width: 3))
            case .toolbar:
                let fill = GradientLayerFill(colors: [.red, .orange, .yellow], style: .axial(direction: .topToBottom, locations: nil))
                //let fill = FlatLayerFill(color: UIColor.blue.withAlphaComponent(0.85) )
                let outline = DashedLayerOutline(color: .yellow, width: 5, lineDashPattern: [3, 3])
                //let outline = LinearLayerOutline(color:.yellow, width: 4)
                return LayerStyle(fill: fill, outline: outline)
            }
        }

        if let section = section as? Section {
            switch section {
            case .first:
                return LayerStyle(fill: FlatLayerFill(color: .lightGray))
            case .second:
                return LayerStyle(fill: ImageLayerFill(image: UIImage(named: "discount-ticket")!, resizingMode: .stretch))
            case .third:
                return LayerStyle(fill: GradientLayerFill(colors: [.red, .orange, .yellow], style: .axial(direction: .topToBottom, locations: nil)))
            case .fourth:
                return LayerStyle(fill: FlatLayerFill(color: .lightGray))
            }
        }
        return LayerStyle(fill: FlatLayerFill(color: .black))
    }
}
