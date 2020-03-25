//
//  ThirdViewController.swift
//  Stylable-UIKit_Example
//

import UIKit
import StylableUIKit

enum AnimatedAsset: StylistAsset {
    case loader

    var name: String {
        switch self {
        case .loader:
            return "loader_dark"
        }
    }
}

final class FourthViewController: UIViewController, StylableViewController {
    var stylableSection: StylistSection = Section.fourth

    @IBOutlet private weak var postSubviewAnimatedAssetContainer: UIView!
    @IBOutlet private weak var preSubviewAnimatedAssetContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Play the asset before adding to the subview and after adding to the subview
        if let animatedAsset = self.stylist.animatedAsset(AnimatedAsset.loader, element: nil, section: self.stylableSection) {
            animatedAsset.playLooped()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                animatedAsset.frame = self?.preSubviewAnimatedAssetContainer.bounds ?? .zero
                animatedAsset.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                self?.preSubviewAnimatedAssetContainer.addSubview(animatedAsset)
            }
        }

        if let animatedAsset = self.stylist.animatedAsset(AnimatedAsset.loader, element: nil, section: self.stylableSection) {
            animatedAsset.frame = self.postSubviewAnimatedAssetContainer.bounds
            animatedAsset.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.postSubviewAnimatedAssetContainer.addSubview(animatedAsset)
            animatedAsset.playLooped()
        }
    }
}
