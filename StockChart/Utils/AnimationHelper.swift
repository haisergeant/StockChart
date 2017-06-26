//
//  AnimationHelper.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/27/17.
//  Copyright © 2017 haile. All rights reserved.
//

import Foundation
import UIKit

class AnimationHelper {
    class func rotateAnimation(angle: Double, time: TimeInterval, repeating: Bool) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * angle / 180.0
        animation.duration = time
        animation.repeatCount = repeating ? .infinity : 0        
        return animation
    }
}
