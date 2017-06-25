//
//  StockListViewController.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/24/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit
import SnapKit

protocol StockListViewControllerInput {
    func display(viewModel: StockListViewModel)
}

protocol StockListViewControllerOutput {
    func load(request: StockListRequest)
}

fileprivate let STOCK_LIST = ["\"APPL\"", "\"GOOG\"", "\"YHOO\"", "\"DOW J\"", "\"FTSE 100\""]


class StockListViewController: BaseViewController {
    let tableView = UITableView()
    
    var output: StockListViewControllerOutput!
    var router: StockListRouterInput!
    
    struct Copy {
        static let titleText = "STOCK_LIST_PAGE_TITLE".localized()
    }
    
    var contents: [AnyObject]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func navigationTitle() -> String {
        return Copy.titleText
    }
    
    override func initialize() {
        StockListConfigurator.sharedInstance.configure(viewController: self)
    }
    
    override func shouldShowNavigationBar() -> Bool {
        return true
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        self.view.addSubview(self.tableView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.load(request: StockListRequest(symbolList: STOCK_LIST))
    }
}

extension StockListViewController: StockListViewControllerInput {
    func display(viewModel: StockListViewModel) {
        
    }
}

extension StockListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let contents = self.contents {
            return contents.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let contents = self.contents, contents.count > 0 {
            
        }
        return UITableViewCell()
    }
}

extension StockListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


