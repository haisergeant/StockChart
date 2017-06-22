//
//  ReactiveCocoa+Utils.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/23/17.
//  Copyright © 2017 haile. All rights reserved.
//


import UIKit
import ReactiveCocoa
import ReactiveSwift
import enum Result.NoError

extension UIButton {
    @discardableResult
    func action(with block: ((UIButton) -> Void)?) -> CocoaAction<UIButton> {
        let cocoaAction = CocoaAction.action(for: self, with: block)
        self.reactive.pressed = cocoaAction
        return cocoaAction
    }
}

extension CocoaAction {
    static func action<P: PropertyProtocol>(for input: Sender, enabledIf: P, with block: ((Sender) -> Void)?) -> CocoaAction where P.Value == Bool {
        let action = Action<Sender, Void, NoError>(enabledIf: enabledIf) { input in
            block?(input)
            return SignalProducer.empty
        }
        let cocoaAction = self.init(action) { _ in
            return input
        }
        return cocoaAction
    }
    
    static func action(for input: Sender, with block: ((Sender) -> Void)?) -> CocoaAction {
        let action = Action<Sender, Void, NoError> { input in
            block?(input)
            return SignalProducer.empty
        }
        let cocoaAction = self.init(action) { _ in
            return input
        }
        return cocoaAction
    }
}
