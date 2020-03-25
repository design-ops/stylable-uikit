//
//  Lottie+StylistAnimatedAsset.swift
//  StylableUIKit
//

import Foundation
import Lottie

extension AnimationView: AnimatedAssetMethods {

    public func playOnce(fromProgress: CGFloat, toProgress: CGFloat, completion: ((Bool) -> Void)?) {
        self.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: .playOnce, completion: completion)
    }

    public func playLooped(fromProgress: CGFloat, toProgress: CGFloat) {
        self.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: .loop, completion: nil)
    }
}
