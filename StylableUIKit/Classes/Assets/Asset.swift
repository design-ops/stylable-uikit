//
//  UIImage+Variants
//  StylableUIKit
//

import UIKit

public final class Asset: BasicAsset, VariantStyleProvider {
    public func variant(_ variant: StylistVariant) -> BasicAsset? {
        return self.getVariant(variant, from: self.variants)
    }

    public func variantOrDefault(_ variant: StylistVariant) -> BasicAsset {
        return self.variant(variant) ?? self
    }

    private var variants: [BasicAsset] = []

    public init(image: UIImage,
                variantType: StylistVariant = UIControl.State.normal,
                variants: [BasicAsset] = []) {
        super.init(image: image,
                   variantType: variantType)
        self.variants = variants
    }
}

public class BasicAsset: VariantStyle {
    public let image: UIImage

    public private(set) var variantType: StylistVariant

    public init(image: UIImage,
                variantType: StylistVariant = UIControl.State.normal) {
        self.image = image
        self.variantType = variantType
    }
}
