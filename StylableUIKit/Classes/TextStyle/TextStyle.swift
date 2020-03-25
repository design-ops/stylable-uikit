//
//  TextStyle.swift
//  StylableUIKit
//

import UIKit

/**
 Collection of attributes to apply to textual elements.
 */
public final class TextStyle: BasicTextStyle, VariantStyleProvider {

    public func variant(_ variant: StylistVariant) -> BasicTextStyle? {
        return self.getVariant(variant, from: self.variants)
    }

    public func variantOrDefault(_ variant: StylistVariant) -> BasicTextStyle {
        return self.variant(variant) ?? self
    }

    private var variants: [BasicTextStyle]  = []

    public init(font: UIFont,
                textColor: UIColor,
                backgroundColor: UIColor? = .clear,
                lineSpacing: CGFloat = 0,
                letterSpacing: CGFloat = 0,
                textAlignment: NSTextAlignment = .left,
                textTransform: TextTransform = .none,
                variantType: StylistVariant = UIControl.State.normal,
                variants: [BasicTextStyle] = []) {
        super.init(font: font,
                   textColor: textColor,
                   backgroundColor: backgroundColor,
                   lineSpacing: lineSpacing,
                   letterSpacing: letterSpacing,
                   textAlignment: textAlignment,
                   textTransform: textTransform,
                   variantType: variantType)
        self.variants = variants
    }
}

public class BasicTextStyle: VariantStyle {
    public let font: UIFont
    public let textColor: UIColor
    public let backgroundColor: UIColor?
    public let letterSpacing: CGFloat
    public let lineSpacing: CGFloat
    public let textAlignment: NSTextAlignment
    public let variantType: StylistVariant
    public let textTransform: TextTransform

    public init(font: UIFont,
                textColor: UIColor,
                backgroundColor: UIColor? = .clear,
                lineSpacing: CGFloat = 0,
                letterSpacing: CGFloat = 0,
                textAlignment: NSTextAlignment = .left,
                textTransform: TextTransform = .none,
                variantType: StylistVariant = UIControl.State.normal) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.lineSpacing = lineSpacing
        self.letterSpacing = letterSpacing
        self.textAlignment = textAlignment
        self.variantType = variantType
        self.textTransform = textTransform
    }
}

extension BasicTextStyle {

    public func apply(_ string: String?) -> NSAttributedString {
        let string: String = {
            guard let string = string else { return "" }
            switch self.textTransform {
            case .uppercased:
                return string.uppercased()
            case .lowercased:
                return string.lowercased()
            case .capitalized:
                return string.capitalized
            case .none:
                return string
            }
        }()
        return NSAttributedString(string: string).applyingAttributes(self.attributes)
    }

    public func apply(_ string: NSAttributedString?) -> NSAttributedString {

        let string: NSAttributedString = {
            guard let string = string else { return NSAttributedString(string: "") }
            switch self.textTransform {
            case .uppercased:
                return string.uppercased()
            case .lowercased:
                return string.lowercased()
            case .capitalized:
                return string.capitalized
            case .none:
                return string
            }
        }()
        return string.applyingAttributes(self.attributes, preservingCurrent: false)
    }
}

extension BasicTextStyle {
    var attributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = self.lineSpacing
        paragraphStyle.alignment = self.textAlignment
        let backgroundColor = self.backgroundColor ?? .clear
        return [ .font: self.font,
                 .foregroundColor: self.textColor,
                 .kern: self.letterSpacing,
                 .backgroundColor: backgroundColor,
                 .paragraphStyle: paragraphStyle
        ]
    }
}
