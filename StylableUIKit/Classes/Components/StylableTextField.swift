//
//  StylableTextField.swift
//  StylableUIKit
//

import Foundation
import UIKit

public final class StylableTextField: UITextField {

    private var textStyle: BasicTextStyle?
    private var placeholderTextStyle: BasicTextStyle?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        self.addTarget(self, action: #selector(ensureStyle), for: .editingDidBegin)
        self.addTarget(self, action: #selector(ensureStyle), for: .editingChanged)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.addTarget(self, action: #selector(ensureStyle), for: .editingDidBegin)
        self.addTarget(self, action: #selector(ensureStyle), for: .editingChanged)
    }

    override public var text: String? {
        didSet {
            guard let textStyle = self.textStyle else { return }
            self.applyTextStyle(textStyle)
        }
    }

    override public var placeholder: String? {
        didSet {
            guard let textStyle = self.placeholderTextStyle else { return }
            self.applyPlaceholderTextStyle(textStyle)
        }
    }

    override public var attributedText: NSAttributedString? {
        set { super.attributedText = newValue.map { self.applyTextStyleTo(attributedText: $0, textStyle: self.textStyle) } }
        get { return super.attributedText }
    }

    override public var attributedPlaceholder: NSAttributedString? {
        set { super.attributedPlaceholder = newValue.map { self.applyTextStyleTo(attributedText: $0, textStyle: self.placeholderTextStyle) } }
        get { return super.attributedPlaceholder }
    }

    public func setTextStyle(_ textStyle: BasicTextStyle) {
        self.textStyle = textStyle
        self.applyTextStyle(textStyle)
    }

    public func setPlaceholderTextStyle(_ textStyle: BasicTextStyle) {
        self.placeholderTextStyle = textStyle
        self.applyPlaceholderTextStyle(textStyle)
    }

    private func applyTextStyle(_ textStyle: BasicTextStyle) {
        self.defaultTextAttributes = textStyle.attributes
        self.attributedText = self.attributedText.map { self.applyTextStyleTo(attributedText: $0, textStyle: self.textStyle) }
    }

    private func applyPlaceholderTextStyle(_ textStyle: BasicTextStyle) {
        self.attributedPlaceholder = self.attributedPlaceholder.map { self.applyTextStyleTo(attributedText: $0, textStyle: self.placeholderTextStyle) }
    }

    private func applyTextStyleTo(attributedText: NSAttributedString, textStyle: BasicTextStyle?) -> NSAttributedString {
        guard let textStyle = textStyle else { return attributedText }
        return textStyle.apply(attributedText)
            .applyingAttributes([.backgroundColor: textStyle.backgroundColor ?? self.backgroundColor ?? .clear],
                                preservingCurrent: false)
    }

    @objc private func ensureStyle() {
        self.typingAttributes = self.textStyle?.attributes
    }
}
