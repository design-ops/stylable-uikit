//
//  UIViewController+skin.swift
//  StylableUIKit
//

import Foundation
import UIKit

private var associatedObjectHandleStylist: UInt8 = 0
private var associatedObjectHandleObserver: UInt8 = 1

/// UIViewControllers can get a default implementation of Stylable using associated objects.
extension UIViewController: Stylable {

    /// Returns the stylist attached to this view controller
    public var stylist: Stylist! {

        // If we have an explicit stylist, use that one
        let boxed = objc_getAssociatedObject(self, &associatedObjectHandleStylist) as? BoxedStylist
        if let stylist = boxed?.stylist {
            return stylist
        }

        // We got to the root of the tree, and there wasn't a stylist
        fatalError("Stylist not set on \(self)")
    }

    /// uses the Stylable protocol to get hold of `stylist` in the first place
    public func style(stylist: Stylist, section: StylistSection) {
        let boxed = BoxedStylist(stylist: stylist)
        objc_setAssociatedObject(self,
                                 &associatedObjectHandleStylist,
                                 boxed,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        if let stylableVC = self as? StylableViewController {
            if let view = self.viewIfLoaded { // if the view is loaded, then apply the style
                stylist.layerStyle(DefaultLayerStyle.background,
                                   element: nil,
                                   section: stylableVC.stylableSection).apply(view)
            } else { // if the view is not loaded then use KVO to wait until it is
                let observer = self.observe(\.view, options: [.new]) { [weak self] (_, _) in
                    guard let self = self else { return }
                    self.stylist.layerStyle(DefaultLayerStyle.background,
                                            element: nil,
                                            section: stylableVC.stylableSection).apply(self.view)
                    // remove associated object (set value to nil)
                    objc_setAssociatedObject(self,
                                             &associatedObjectHandleObserver,
                                             nil,
                                             objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
                objc_setAssociatedObject(self,
                                         &associatedObjectHandleObserver,
                                         observer,
                                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        } else {
            print("⚠️ WARNING: ViewController \(String(describing: self)) should implement StylableViewController")
        }
    }
}

/**
 You can't just store a Stylist protocol directly as an associated object
 because the cast back to `as? Stylist` doesn't work when you try to
 retrieve it. You can however, store a concrete type, and extract the
 stylist as a property from that. This is that concrete type.
 */
private struct BoxedStylist {
    let stylist: Stylist
}
