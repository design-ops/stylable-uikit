//
//  RestrictedLayerStylable
//  StylableUIKit
//

import Foundation

// MARK: - SimpleLayerStylable
/// Handle UIViews which don't play well with sub UIViews, eg UILabel and UINavigationBar where the subview sits above the text
@objc public protocol RestrictedLayerStylable {
    @objc func setBackground(color: UIColor)
    // func setBackground(image: UIImage)
}

extension UILabel: RestrictedLayerStylable {
    public func setBackground(color: UIColor) {
        self.backgroundColor = color
    }
}

extension UINavigationBar: RestrictedLayerStylable {
    public func setBackground(color: UIColor) {
        self.barTintColor = color
        self.setBackgroundImage(nil, for: .default)
    }
}

extension UIImageView: RestrictedLayerStylable {
    public func setBackground(color: UIColor) {
        self.backgroundColor = color
    }
}
