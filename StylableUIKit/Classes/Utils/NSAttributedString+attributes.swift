//
//  NSAttributedString+attributes.swift
//  StylableUIKit
//

import UIKit

fileprivate extension NSMutableAttributedString {

    func addMissingAttribute(_ attr: NSAttributedString.Key, value: Any, range: NSRange) {
        self.enumerateAttribute(attr, in: range, options: []) { found, range, _ in
            if found == nil {
                self.addAttribute(attr, value: value, range: range)
            }
        }
    }
}

public extension NSAttributedString {

    /**
     Returns a new `NSAttributedString` with the specified attributes set.

     - parameter attributes: A dictionary of the attributes to apply
     - parameter range: _(optional)_ The range to apply the new attributes to (`nil` applies to the whole string).
     - parameter preservingCurrent: _(optional)_ `true` to keep previous values of each attribute in the current string, `false` to apply to the whole string.
     */
    func applyingAttributes(_ attributes: [ NSAttributedString.Key: Any], range: NSRange? = nil, preservingCurrent: Bool = true) -> NSAttributedString {
        let range = range ?? NSRange(location: 0, length: self.length)

        let string = NSMutableAttributedString(attributedString: self)

        for (attr, value) in attributes {
            if preservingCurrent {
                string.addMissingAttribute(attr, value: value, range: range)
            } else {
                string.addAttribute(attr, value: value, range: range)
            }
        }

        return string
    }

    /**
     Returns a new `NSAttributedString` with the specified attribute set.

     - parameter attr: The attribute to set
     - parameter value: The new value to set it to
     - parameter range: _(optional)_ The range to apply the new attribute to (`nil` applies to the whole string).
     - parameter preservingCurrent: _(optional)_ `true` to keep previous values of `attr` in the current string, `false` to apply to the whole string.
     */
    func applyingAttribute(_ attr: NSAttributedString.Key, value: Any, range: NSRange? = nil, preservingCurrent: Bool = true) -> NSAttributedString {
        return self.applyingAttributes([attr: value], range: range, preservingCurrent: preservingCurrent)
    }

    /**
     Returns a new attributed string with the specified font applied.

     - parameter font: The font to apply
     - parameter range: _(optional)_ The range to apply the new font to (`nil` applies to the whole string).
     - parameter preservingCurrent: _(optional)_ `true` to keep previous fonts (where they have ben set), `false` to apply to the whole string.
     */
    func applyingFont(_ font: UIFont, range: NSRange? = nil, preservingCurrent: Bool = true) -> NSAttributedString {
        return self.applyingAttribute(.font,
                                      value: font,
                                      range: range,
                                      preservingCurrent: preservingCurrent)
    }

    /**
     Returns a new attributed string with the specified foreground color applied.

     - parameter color: The color to apply
     - parameter range: _(optional)_ The range to apply the new color to (`nil` applies to the whole string).
     - parameter preservingCurrent: _(optional)_ `true` to keep previous foreground colours (where they have ben set), `false` to apply to the whole string.
     */
    func applyingTextColor(_ color: UIColor, range: NSRange? = nil, preservingCurrent: Bool = true) -> NSAttributedString {
        return self.applyingAttribute(.foregroundColor,
                                      value: color,
                                      range: range,
                                      preservingCurrent: preservingCurrent)
    }

    /**
     Returns a new attributed string with the specified alignment and line spacing applied across its total range
     */
    func applyingParagraphStyle(alignment: NSTextAlignment = .center,
                                lineSpacing: CGFloat = 0) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment

        return self.applyingParagraphStyle(paragraphStyle)
    }

    /**
     Returns a new attributed string with the specified paragraph style applied across its total range
     */
    func applyingParagraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: self)
        string.addAttribute(.paragraphStyle,
                            value: paragraphStyle,
                            range: NSRange(location: 0, length: string.length))
        return string
    }

    /// This method will iterate over all the paragraph styles in the reciever (adding empty styles for sections where there is
    /// no current paragraph style) and pass a mutable copy into the mutation parameter. This mutated style with then replace the
    /// original style.
    ///
    /// - parameter range: The range over which to update the paragraph
    /// - parameter mutation: The mutation to apply to the paragraph style
    /// - returns: An `NSAttributedString` with the mutation applied over the entire of `range`
    private func updatingParagraph(range: NSRange? = nil, mutation: (NSMutableParagraphStyle) -> Void) -> NSAttributedString {
        let range = range ?? NSRange(location: 0, length: self.length)

        let string = NSMutableAttributedString(attributedString: self)

        string.enumerateAttribute(.paragraphStyle, in: range, options: []) { value, range, _ in
            let style: NSMutableParagraphStyle

            if let value = value as? NSParagraphStyle, let foundStyle = value.mutableCopy() as? NSMutableParagraphStyle {
                style = foundStyle
            } else {
                style = NSMutableParagraphStyle()
            }

            mutation(style)

            string.addAttributes([.paragraphStyle: style], range: range)
        }

        return string
    }

    /// This will apply the specified text alignment to the string. All currently existing alignments will be overridden.
    ///
    /// - parameter alignment: The new alignment to be applied to the string
    /// - parameter range: _(optional)_ The range of the string over which to apply the new alignment. Passing in `nil` will cover the whole string.
    func applyingAlignment(_ alignment: NSTextAlignment, range: NSRange? = nil) -> NSAttributedString {
        return self.updatingParagraph(range: range) { style in
            style.alignment = alignment
        }
    }

    /// This will apply the specified line spacing to the string. All currently existing spacings will be overridden.
    ///
    /// - parameter spacing: The new line spacing
    /// - parameter range: _(optional)_ The range of the string over which to apply the new spacing. Passing in `nil` will cover the whole string.
    func applyingLineSpacing(_ spacing: CGFloat, range: NSRange? = nil) -> NSAttributedString {
        return self.updatingParagraph(range: range) { style in
            style.lineSpacing = spacing
        }
    }

    /// This will apply the specified line break mode.
    ///
    /// - parameter lineBreakMode: The new line break mode to be applied to the string.
    func applyingLineBreakMode(_ lineBreakMode: NSLineBreakMode) -> NSAttributedString {
        return self.updatingParagraph(range: nil) { style in
            style.lineBreakMode = lineBreakMode
        }
    }

    /// Remove any line height attributes. iOS will always add the extra height to a line even if there is only one. This line height will
    /// be applied over the entire string.
    func singleLine() -> NSAttributedString {
        return self.updatingParagraph { style in
            style.lineSpacing = 0
        }
    }
}
