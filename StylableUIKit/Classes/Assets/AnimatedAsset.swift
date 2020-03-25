//
//  AnimatedAsset.swift
//  StylableUIKit
//

import Foundation

public typealias StylistAnimatedAsset = UIView & AnimatedAssetMethods

public protocol AnimatedAssetMethods {
    /// play an animation once from the beginning
    func playOnce()
    /// play an animation once from 'fromProgress' to 'toProgress' and call 'completion' when done
    func playOnce(fromProgress: CGFloat, toProgress: CGFloat, completion: ((Bool) -> Void)?)
    /// play an animation from the beginning and when it reaches the end return to the beginning and continue playing
    func playLooped()
    /// play an animation from 'fromProgress' and when it reaches 'toProgress' return to 'fromProgress' and continue playing
    func playLooped(fromProgress: CGFloat, toProgress: CGFloat)
    /// stop the animation playing and return to the first frame
    func stop()
}

/// This extension allows UIImageViews to be returned from Stylist's `animatedAsset()` method
extension UIImageView: AnimatedAssetMethods {

    public func playOnce(fromProgress: CGFloat, toProgress: CGFloat, completion: ((Bool) -> Void)?) { }

    public func playLooped(fromProgress: CGFloat, toProgress: CGFloat) { }

    public func stop() { }

}

/// Provide convenience shortcuts for playOnce and playLooped
public extension AnimatedAssetMethods {

    func playOnce() {
        self.playOnce(fromProgress: 0, toProgress: 1, completion: nil)
    }

    func playLooped() {
        self.playLooped(fromProgress: 0, toProgress: 1)
    }
}
