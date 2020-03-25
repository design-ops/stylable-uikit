//
//  String+Lottie
//  StylableUIKit
//

import UIKit
import Lottie

public extension String {

    func asLottieAnimationView(from bundle: Bundle = Bundle.main) -> StylistAnimatedAsset? {
        if bundle.path(forResource: self, ofType: "json") != nil {
            return AnimationView(name: self)
        }
        return nil
    }

}
