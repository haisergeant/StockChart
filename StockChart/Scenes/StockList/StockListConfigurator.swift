//
//  StockListConfigurator.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/24/17.
//  Copyright (c) 2017 haile. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension StockListViewController: StockListPresenterOutput {
}

extension StockListInteractor: StockListViewControllerOutput {
}

extension StockListPresenter: StockListInteractorOutput {
}

class StockListConfigurator {
    // MARK: - Object lifecycle
    static let sharedInstance = StockListConfigurator()
    private init() {}
    // MARK: - Configuration
    func configure(viewController: StockListViewController) {
        let router = StockListRouter()
        router.viewController = viewController
        
        let presenter = StockListPresenter()
        presenter.output = viewController
        
        let interactor = StockListInteractor()
        interactor.repository = ServerRepository.instance
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
