//
//  StylableTextView.swift
//  StylableUIKit
//

import Foundation
import UIKit

public final class StylableTextView: UITextView {

    private var textStyle: BasicTextStyle?

    override public var text: String? {
        didSet {
            guard let textStyle = self.textStyle else { return }
            self.applyTextStyle(textStyle)
        }
    }

    override public var attributedText: NSAttributedString? {
        set { super.attributedText = newValue.map { self.applyTextStyleTo(attributedText: $0) } }
        get { return super.attributedText }
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
        return textStyle.apply(attributedText)
            .applyingAttributes([.backgroundColor: textStyle.backgroundColor ?? self.backgroundColor ?? .clear],
                                preservingCurrent: false)
    }
}
