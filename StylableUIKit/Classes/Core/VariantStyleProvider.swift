//
//  VariantStyleProvider.swift
//  StylableUIKit
//

import Foundation

public protocol VariantStyleProvider: VariantStyle {
    associatedtype Style

    /// - returns: Either the requested variant, or nil.
    func variant(_: StylistVariant) -> Style?

    /// - returns: Either the requested variant, or `self`.
    func variantOrDefault(_: StylistVariant) -> Style
}

extension VariantStyleProvider {
    func getVariant<Style: VariantStyle>(_ variant: StylistVariant, from array: [Style]) -> Style? {
        guard let item = array.first(where: { $0.variantType.name == variant.name }) else {
            if variant.name == self.variantType.name { return self as? Style }
            return nil
        }
        return item
    }
}

public protocol VariantStyle {
    var variantType: StylistVariant { get }
}
