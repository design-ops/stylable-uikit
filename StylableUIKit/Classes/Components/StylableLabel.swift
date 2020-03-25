//
//  StylableLabel.swift
//  StylableUIKit
//

import Foundation
import UIKit

/// A UILabel subclass that is stylable. Setting the text or attributed text will automatically
/// style this label with the text style it has, if any.

public final class StylableLabel: UILabel {

    private var textStyle: BasicTextStyle?

    override public var text: String? {
        didSet {
            guard self.text != oldValue,
                let textStyle = self.textStyle else { return }
            self.applyTextStyle(textStyle)
            self.applyMultilineString()
        }
    }

    override public var attributedText: NSAttributedString? {
        set {
            super.attributedText = newValue.map { self.applyTextStyleTo(attributedText: $0) }
            self.applyMultilineString()
        }
        get {
            return super.attributedText
        }
    }

    public func setTextStyle(_ textStyle: BasicTextStyle) {
        self.textStyle = textStyle
        self.applyTextStyle(textStyle)
    }

    private func applyTextStyle(_ textStyle: BasicTextStyle) {
        self.attributedText = self.attributedText.map { self.applyTextStyleTo(attributedText: $0) }
    }

    private func applyTextStyleTo(attributedText: NSAttributedString) -> NSAttributedString {
        guard let textStyle = self.textStyle else { return attributedText }
        return textStyle.apply(attributedText).applyingLineBreakMode(self.lineBreakMode)
    }
}

extension StylableLabel {

    /// Applies text with a given style to a Label, and if that text is only one line it removes the line spacing from the label
    /// to help layout. Otherwise UIKit will add the line spacing to the bottom of a single line label, which is fantastically bad
    /// for layouts.
    ///
    fileprivate func applyMultilineString() {
        guard
            self.text != nil,
            let textStyle = self.textStyle else {
                return
        }

        // If that style results in a single line, remove the line height
        if self.isSingleLine && textStyle.lineSpacing > 0 {
            super.attributedText = self.attributedText?.applyingLineSpacing(0)
        }
    }

    /// This returns `true` if the attributed text in the label can be rendered in the current `bounds.width` of the label. Otherwise, it returns `false`.
    ///
    /// - warning: This, obviously, requires rendering some text twice. It's exactly as performant as you would expect.

    /// - warning: We need to be careful with how we've set the Line Break Mode.
    ///            i.e. if we're rendering a label which Line Break Mode is Truncate Tail, its height will still be as if it had only one line of text:

    /// "This is an example..."

    /// when, what we might want to render is:

    /// "This is an example of
    /// a big text for a small
    /// label to check if it
    /// should be more than
    /// one line"

    private var isSingleLine: Bool {

        guard
            let attributedText = self.attributedText,
            self.numberOfLines != 1 else {
            return true
        }

        // Get the height of the wrapped text
        let wrappedSize = CGSize(width: self.bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        let wrappedRect = attributedText.boundingRect(with: wrappedSize,
                                                      options: [ .usesLineFragmentOrigin ],
                                                      context: nil)

        // Get the height of a single line of text
        let singleSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let singleRect = attributedText.boundingRect(with: singleSize,
                                                     options: [ .usesLineFragmentOrigin ],
                                                     context: nil)

        // Only add the line spacing if we are going to render in multiple lines
        return ceil(wrappedRect.size.height) <= ceil(singleRect.size.height)
    }
}
