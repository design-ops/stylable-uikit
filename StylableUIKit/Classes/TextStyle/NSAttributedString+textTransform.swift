//
//  NSAttributedString+textTransform.swift
//  StylableUIKit
//

import Foundation

extension NSAttributedString {

    private func applyToWholeString(_ map: (String) throws -> String) rethrows -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)

        result.replaceCharacters(in: NSRange(location: 0, length: result.length), with: try map(result.string))

        return result
    }

    func uppercased() -> NSAttributedString {
        return self.applyToWholeString { $0.uppercased() }
    }

    func lowercased() -> NSAttributedString {
        return self.applyToWholeString { $0.lowercased() }
    }

    var capitalized: NSAttributedString {
        return self.applyToWholeString { $0.capitalized }
    }
}
