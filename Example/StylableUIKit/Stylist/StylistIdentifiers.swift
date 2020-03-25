//
//  StylistIdentifiers.swift
//  Stylable-UIKit_Example
//

import Foundation
import StylableUIKit

enum Section: String, StylistSection, CaseIterable {
    case first
    case second
    case third
    case fourth
}

enum Element: String, StylistElement {
    case primaryButton
    case secondaryButton
    case label
    case textField
    case textView
    case toolbar
}

enum TextType: String, StylistTextStyle {

    case title
    case subtitle
    case heading
    case subheading
    case primaryText
    case secondaryText
    case tertiaryText
    case warningText
    case successText
}

public enum LayerType: String, StylistLayerStyle {

    case background
    case line
}
