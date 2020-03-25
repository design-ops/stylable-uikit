//
//  AssetIdentifier.swift
//  StylableUIKit
//

import Foundation

public protocol StylistIdentifier {
    var name: String { get }
}

public protocol StylistAsset: StylistIdentifier { }

public protocol StylistElement: StylistIdentifier { }

public protocol StylistSection: StylistIdentifier { }

public protocol StylistMode: StylistIdentifier { }

public protocol StylistVariant: StylistIdentifier { }

public protocol StylistTextStyle: StylistIdentifier {}

public protocol StylistLayerStyle: StylistIdentifier {}

extension StylistIdentifier where Self: RawRepresentable, Self.RawValue == String {
    public var name: String {
        return self.rawValue
    }
}

/// Wrap asset identifiers in this struct to make it implement `Equatable`. This only works if the wrapped
/// asset identifier's type is already `Equatable`.
public struct EquatableStylistIdentifier: Equatable {

    /// The underlying asset identifier used to create this instance, but with it's type removed.
    public let identifier: StylistIdentifier

    /// This block `true` if the passed in asset identifier is the same type, and `==` to the identifier use to create this instance.
    /// `false` otherwise. This is used internally in the implementation of `Equatable`
    fileprivate let isEqual: (_ otherIdentifier: StylistIdentifier) -> Bool

    /// Create an EquatableAssetIdentifier wrapping the passed in identifier. The passed in identifier must also be `Equatable`.
    ///
    /// - parameter identifier: The asset identifier to create this instance.
    public init<U>(_ identifier: U) where U: StylistIdentifier, U: Equatable {
        self.identifier = identifier
        self.isEqual = { ($0 as? U) == identifier }
    }

    public static func == (lhs: EquatableStylistIdentifier, rhs: EquatableStylistIdentifier) -> Bool {
        return lhs.isEqual(rhs.identifier)
    }
}

/// The default type for a Variant is UIControl.State, but it's a protocol so that other Variants can be created
extension UIControl.State: StylistVariant {
    public var name: String {
        switch self {
        case .normal:
            return "normal"
        case .highlighted:
            return "highlighted"
        case .disabled:
            return "disabled"
        case .selected:
            return "selected"
        case .focused:
            return "focused"
        case .application:
            return "application"
        case .reserved:
            return "reserved"
        default:
            return "unknown"
        }
    }
}
