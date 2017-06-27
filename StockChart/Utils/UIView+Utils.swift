//
//  UIView+Utils.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/27/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit

extension UIView {
    public var widthContraint: NSLayoutConstraint? {
        for constraint in self.constraints {
            if constraint.firstAttribute == NSLayoutAttribute.width && constraint.firstItem.isEqual(self) {
                if object_getClassName(constraint) == object_getClassName(NSLayoutConstraint.self) {
                    return constraint
                }
            }
        }
        return nil
    }
    
    public var heightContraint: NSLayoutConstraint? {
        for constraint in self.constraints {
            if constraint.firstAttribute == NSLayoutAttribute.height && constraint.firstItem.isEqual(self) {
                if object_getClassName(constraint) == object_getClassName(NSLayoutConstraint.self) {
                    return constraint
                }
            }
        }
        return nil
    }
    
    public func commonSuperview(with view: UIView) -> UIView? {
        var commonSuperview: UIView?
        var startView: UIView? = self
        repeat {
            if view.isDescendant(of: startView!) {
                commonSuperview = startView
            }
            startView = startView!.superview
        } while startView != nil && commonSuperview == nil
        return commonSuperview
    }
}

extension NSLayoutConstraint {
    public func remove() {
        if let firstItem = self.firstItem as? UIView {
            if let secondItem = self.secondItem as? UIView {
                var commonSuperview = firstItem.commonSuperview(with: secondItem)
                while commonSuperview != nil {
                    if commonSuperview!.constraints.contains(self) {
                        commonSuperview!.removeConstraint(self)
                        return
                    }
                    commonSuperview = commonSuperview!.superview
                }
            } else {
                firstItem.removeConstraint(self)
            }
        }
    }
}
