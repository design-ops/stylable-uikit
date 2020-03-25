//
//  FirstViewController.swift
//  Stylable-UIKit_Example
//

import Foundation
import UIKit

import StylableUIKit

enum StylableButtonMode: StylableUIKit.ButtonMode {

    case primary, secondary

    var element: StylistElement {
        switch self {
        case .primary: return Element.primaryButton
        case .secondary: return Element.secondaryButton
        }
    }

    var layerStyle: StylistLayerStyle? { LayerType.background }

    var textStyle: StylistTextStyle { TextType.title }
}

class FirstViewController: UIViewController, StylableViewController {

    var stylableSection: StylistSection = Section.first

    @IBOutlet weak private var primaryButton: StylableButton!
    @IBOutlet weak private var secondaryButton: StylableButton!
    @IBOutlet weak private var stylableLabel: StylableLabel!
    @IBOutlet weak private var stylableTextField: StylableTextField!
    @IBOutlet weak private var stylableTextView: StylableTextView!
    @IBOutlet weak private var placeholderStylabelTextField: StylableTextField!
    @IBOutlet weak private var stackViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak private var toolbar: UIToolbar!
    @IBOutlet weak private var navbar: UINavigationBar!
    @IBOutlet weak private var tabbar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.primaryButton.style(mode: StylableButtonMode.primary, stylist: self.stylist, section: self.stylableSection)
        self.secondaryButton.style(mode: StylableButtonMode.secondary, stylist: self.stylist, section: self.stylableSection)

        self.stylist.layerStyle(LayerType.background, element: Element.label, section: self.stylableSection).apply(self.stylableLabel)
        self.stylist.layerStyle(LayerType.background, element: Element.textField, section: self.stylableSection).apply(self.stylableTextField)
        self.stylist.layerStyle(LayerType.background, element: Element.textView, section: self.stylableSection).apply(self.stylableTextView)
        self.stylist.layerStyle(LayerType.background, element: Element.toolbar, section: self.stylableSection).apply(self.toolbar)
        self.stylist.layerStyle(LayerType.background, element: Element.toolbar, section: self.stylableSection).apply(self.navbar)
        self.stylist.layerStyle(LayerType.background, element: Element.toolbar, section: self.stylableSection).apply(self.tabbar)

        self.placeholderStylabelTextField.setPlaceholderTextStyle(self.stylist.textStyle(TextType.secondaryText, element: Element.textField, section: Section.first))
        self.placeholderStylabelTextField.setTextStyle(self.stylist.textStyle(TextType.primaryText, element: Element.textField, section: Section.first))
    }

    @IBAction func onTapPrimaryButton(_ sender: Any) {
        print("Primary tap")
        self.stackViewWidthConstraint.constant = (self.stackViewWidthConstraint.constant > 250)
            ? 241 : self.view.bounds.width

    }

    @IBAction func onTapSecondaryButton(_ sender: Any) {
        print("Secondary tap")
        self.stackViewWidthConstraint.constant = (self.stackViewWidthConstraint.constant > 250)
            ? 241 : self.view.bounds.width
    }
}
