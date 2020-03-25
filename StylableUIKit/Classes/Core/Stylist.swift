//
//  Stylist.swift
//  StylableUIKit
//

import Foundation
import UIKit

/// Implement this to style the platform components. Pass it into SeamlessPlatform and it will be called to get styles
/// for the UI components
public protocol Stylist {

    func asset(_ identifier: StylistAsset, element: StylistElement?, section: StylistSection?) -> Asset?

    func animatedAsset(_ identifier: StylistAsset, element: StylistElement?, section: StylistSection?) -> StylistAnimatedAsset?

    func textStyle(_ style: StylistTextStyle, element: StylistElement?, section: StylistSection?) -> TextStyle

    func layerStyle(_ style: StylistLayerStyle, element: StylistElement?, section: StylistSection?) -> LayerStyle

}

/// Implement this protocol to be given a stylist.
public protocol Stylable {
    func style(stylist: Stylist, section: StylistSection)
}

public protocol StylableWithMode {
    associatedtype Mode: StylistMode

    func style(mode: Mode, stylist: Stylist, section: StylistSection)
}

/// Helpful protocol to consistently give view controllers an idea of their section.
public protocol StylableViewController: Stylable {
    var stylableSection: StylistSection { get }
}
