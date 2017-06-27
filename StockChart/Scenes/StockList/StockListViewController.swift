//
//  StockListViewController.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/24/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

protocol StockListViewControllerInput {
    func display(viewModel: StockListViewModel)
}

protocol StockListViewControllerOutput {
    func load(request: StockListRequest)
}

fileprivate let STOCK_LIST = ["\"AAPL\"", "\"GOOG\"", "\"YHOO\"", "\"MSFT\""]


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
    
    override func configureContent() {
        super.configureContent()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
        
        self.tableView.separatorStyle = .none
        self.navigationItem.backBarButtonItem?.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.output.load(request: StockListRequest(symbolList: STOCK_LIST))
    }
}

extension StockListViewController: StockListViewControllerInput {
    func display(viewModel: StockListViewModel) {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.contents = viewModel.modelList
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
            let item = contents[indexPath.row]
            let cell = StockViewCell()
            cell.configure(model: item)
            return cell
        }
        return UITableViewCell()
    }
}

extension StockListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if let item = self.contents?[indexPath.row] as? StockViewModel {
            self.router.navigateToGraph(stock: item.stock)
        }
    }
}
