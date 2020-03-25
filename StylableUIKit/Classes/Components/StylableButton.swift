
import Foundation
import UIKit

/// `StylistMode`, but for buttons.
public protocol ButtonMode: StylistMode {
    var element: StylistElement { get }
    var textStyle: StylistTextStyle { get }
    var layerStyle: StylistLayerStyle? { get }
}

public extension ButtonMode {
    var name: String { self.element.name }
    var layerStyle: StylistLayerStyle? { nil }
}

/// Workaround for Swift not liking protocols as concrete types.
///
/// You shouldn't ever need to see this type in your code, it's only public because Swift requires it.
///
/// Ideally we would just have `ButtonMode` but Swift doesn't like it not being a concrete type when
/// we implement `StylableWithMode` on `StylableButton` so we have to wrap it here. There's an identical method on `StylableButton` which _does_ take in a
/// `ButtonMode` so you should really only need to call that; it will deal with the wrapping for you.
///
public struct ButtonModeWrapper: ButtonMode {

    private let _element: () -> StylistElement
    private let _textStyle: () -> StylistTextStyle
    private let _layerStyle: () -> StylistLayerStyle?
    private let _name: () -> String

    public var element: StylistElement { self._element() }
    public var textStyle: StylistTextStyle { self._textStyle() }
    public var layerStyle: StylistLayerStyle? { self._layerStyle() }
    public var name: String { self._name() }

    init(_ wrapping: ButtonMode) {
        self._textStyle = { wrapping.textStyle }
        self._layerStyle = { wrapping.layerStyle }
        self._element = { wrapping.element }
        self._name = { wrapping.name }
    }
}

/// This UIButton can be styled with a stylist, which will set it's background, and text styles for the various UIControl.State values. The button should
/// then behave exactly as if it were a UIButton i.e. `setTitle(_:for:)` can be called and the only behaviour change would be the extra styling.
///
/// Once the button has been styled, animated assets can be added/removed for the states using `setAnimatedAsset(_:for:)`.
open class StylableButton: UIButton, StylableWithMode {

    open override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            super.isEnabled = newValue
            self.updateAnimatedView()
            self.updateLayerStyle()
        }
    }

    open override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue
            self.updateAnimatedView()
            self.updateLayerStyle()
        }
    }

    open override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.isSelected = newValue
            self.updateAnimatedView()
            self.updateLayerStyle()
        }
    }

    // MARK: Styling

    private var stylist: (stylist: Stylist, section: StylistSection)?

    /// Apply a stylist to the button.
    ///
    /// - note: This won't retroactively style titles which have already been set, call this early on!
    ///
    /// - parameter mode: The button's mode (i.e. primary, secondary etc). These modes aren't provided by this library, we don't know what your app looks like.
    /// - parameter stylist: The stylist used to apply the styles for the specified mode
    /// - parameter section: The app section this button will be in.
    ///
    public func style(mode: ButtonMode, stylist: Stylist, section: StylistSection) {
        self.style(mode: ButtonModeWrapper(mode), stylist: stylist, section: section)
    }

    /// Apply a stylist to the button.
    ///
    /// You almost certainly won't call this method, but will call the other version, passing in a ButtonMode as the mode parameter.
    ///
    /// - note: This won't retroactively style titles which have already been set, call this early on!
    public func style(mode: ButtonModeWrapper, stylist: Stylist, section: StylistSection) {
        self.stylist = (stylist, section)

        self.textStyle = stylist.textStyle(mode.textStyle, element: mode.element, section: section)
        if let layerStyle = mode.layerStyle {
            self.layerStyle = stylist.layerStyle(layerStyle, element: mode.element, section: section)
        }
    }

    // MARK: Text Styles

    private var textStyle: TextStyle? {
        didSet {
            // Reset all the state's text styles with the new text style
            [UIControl.State.normal, .highlighted, .selected, .disabled].forEach { state in
                let title = self.title(for: state)
                self.setTitle(title, for: state)
            }
        }
    }

    // Returns the best text style variant for a state, falling back to the text style of `.normal`.
    private func textStyle(for state: UIControl.State) -> BasicTextStyle? {
        return self.textStyle?.variant(state) ?? self.textStyle?.variant(UIControl.State.normal)
    }

    // MARK: Layer Styles

    private var layerStyle: LayerStyle? {
        didSet {
            self.updateLayerStyle()
        }
    }

    private func layerStyle(for state: UIControl.State) -> BasicLayerStyle? {
        return self.layerStyle?.variant(state) ?? self.layerStyle?.variant(UIControl.State.normal)
    }

    private func updateLayerStyle() {
        // First check if we are enabled
        guard self.isEnabled else {
            self.layerStyle(for: .disabled)?.apply(self)
            return
        }

        if self.isHighlighted {
            self.layerStyle(for: .highlighted)?.apply(self)
            return
        }

        if self.isSelected {
            self.layerStyle(for: .selected)?.apply(self)
            return
        }

        self.layerStyle(for: .normal)?.apply(self)
    }

    // MARK: Animated assets

    private var animatedAssets: [UIControl.State.RawValue: StylistAsset] = [:]

    private var animatedAssetView: UIView? {
        willSet {
            self.animatedAssetView?.removeFromSuperview()
        }
        didSet {
            if let view = self.animatedAssetView, let imageView = self.imageView {
                view.translatesAutoresizingMaskIntoConstraints = false
                view.isUserInteractionEnabled = false
                self.addSubview(view)

                let aspectRatio = view.bounds.size.width / view.bounds.size.height

                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: aspectRatio),
                    view.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                    view.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                    view.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1),
                    view.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 1)
                    ])
            }
        }
    }

    private func updateAnimatedView() {
        guard
            let stylist = self.stylist,
            let asset = self.animatedAssets[self.state.rawValue] else {
                self.animatedAssetView = nil
                return
        }

        self.animatedAssetView = stylist.stylist.animatedAsset(asset, element: nil, section: stylist.section)
    }

    /// Sets the animated asset for a give state. This will only work as expected if `style(mode:stylist:section:)` has already been called.
    open func setAnimatedAsset(_ asset: StylistAsset?, for state: UIControl.State) {
        self.animatedAssets[state.rawValue] = asset

        if asset != nil {
            self.setImage(UIImage(), for: state)
        }

        if state == self.state {
            self.updateAnimatedView()
        }
    }

    // MARK: Overrides

    open override func setTitle(_ title: String?, for state: UIControl.State) {
        guard var string = self.textStyle(for: state)?.apply(title) else {
            print("⚠️ StylableButton has no text style for '\(title ?? "")' - have you called style(mode:stylist:section:) yet?")
            super.setTitle(title, for: state)
            return
        }

        if self.titleLabel?.numberOfLines == 1 {
            string = string.singleLine()
        }
        super.setTitle(title, for: state)
        super.setAttributedTitle(string, for: state)

        // If we are setting the style for normal, we need to set the style for other states of the control,
        // but only if they haven't been set yet, and there is a variant for that style in our root text style
        if state == .normal {
            [UIControl.State.focused, .highlighted, .disabled, .selected].forEach { state in
                guard self.title(for: state) != title else { return }
                self.setTitle(title, for: state)
            }
        }
    }

    /// We need to make 100% sure that the background layer style is always underneath anything that UIButton wants to lazily add in the future.

    private weak var layerStylableView: UIView?

    private var hasLayerStylableView: Bool {
        return self.layerStylableView != nil
    }

    override open func getLayerStylableView() -> UIView {
        if let view = self.layerStylableView { return view }

        let view = UIView()
        view.backgroundColor = .clear
        view.isOpaque = false
        view.isUserInteractionEnabled = false
        view.frame = self.bounds
        view.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        self.insertSubview(view, at: 0)
        self.layerStylableView = view

        return view
    }

    override open func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)

        if self.hasLayerStylableView && view != self.layerStylableView {
            self.sendSubviewToBack(self.getLayerStylableView())
        }
    }

    override open func sendSubviewToBack(_ view: UIView) {
        super.sendSubviewToBack(view)

        if self.hasLayerStylableView && view != self.layerStylableView {
            self.sendSubviewToBack(self.getLayerStylableView())
        }
    }

    override open func insertSubview(_ view: UIView, belowSubview siblingSubview: UIView) {
        super.insertSubview(view, belowSubview: siblingSubview)

        if self.hasLayerStylableView && view != self.layerStylableView {
            self.sendSubviewToBack(self.getLayerStylableView())
        }
    }

    // Multi-line UIButton's don't seem to play well with UIStackViews. I'm not sure if its
    // because of the intrinsic content size or some other property. This fixes the symptoms, but the
    // problem is probably fixed by submitting a radar (radar: 6155421)
    // As a result of the intrinsicContentSize not being constrained to its parent (which is correct!),
    // the height of the button is wrong when you have multiple lines of text.
    open override var intrinsicContentSize: CGSize {
        let imageViewSize = self.imageView?.intrinsicContentSize ?? .zero
        let titleLabelSize = self.titleLabel?.sizeThatFits(self.bounds.size) ?? .zero

        let width = self.contentEdgeInsets.left +
            self.imageEdgeInsets.left +
            imageViewSize.width +
            self.imageEdgeInsets.right +
            self.titleEdgeInsets.left +
            titleLabelSize.width +
            self.titleEdgeInsets.right +
            self.contentEdgeInsets.right

        let height = max(imageViewSize.height + self.imageEdgeInsets.top + self.imageEdgeInsets.bottom,
                         titleLabelSize.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom)

        return CGSize(width: width,
                      height: self.contentEdgeInsets.top + height + self.contentEdgeInsets.bottom)
    }
}
