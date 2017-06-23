//
//  WelcomeRouter.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/24/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit

protocol WelcomeRouterInput {
    func navigateNext()
}

class WelcomeRouter: WelcomeRouterInput {
    weak var viewController: UIViewController!
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateNext() {
        if let navController = self.viewController.navigationController {
            let stockController = StockListViewController()
            navController.pushViewController(stockController, animated: true)
        }
    }
}
