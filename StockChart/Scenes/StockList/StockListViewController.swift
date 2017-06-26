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
    
    override func configureContent() {
        super.configureContent()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.load(request: StockListRequest(symbolList: STOCK_LIST))
    }
}

extension StockListViewController: StockListViewControllerInput {
    func display(viewModel: StockListViewModel) {
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
        
    }
}

class StockViewCell: UITableViewCell {
    let labelSymbol = UILabel()
    let labelPrice = UILabel()
    let labelChange = UILabel()
    
    init() {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: "StockViewCell")
        self.configureSubviews()
    }
    
    func configureSubviews() {
        self.contentView.addSubview(self.labelSymbol)
        self.contentView.addSubview(self.labelPrice)
        self.contentView.addSubview(self.labelChange)
    }
    
    func configure(model: AnyObject) {
        if let model = model as? StockViewModel {
            self.labelSymbol.attributedText = model.labelTitle
            self.labelChange.attributedText = model.changeText
            self.labelPrice.attributedText = model.priceText
            
            self.labelSymbol.snp.makeConstraints { [unowned self] make in
                make.left.equalTo(model.padding.paddingInnerX)
                make.top.equalTo(model.padding.paddingInnerY)
                make.bottom.equalTo(-model.padding.paddingInnerY)
                make.right.equalTo(self.labelPrice.snp.left).offset(-model.padding.paddingBetweenX)
            }
            
            self.labelPrice.snp.makeConstraints { [unowned self] make in
                make.firstBaseline.equalTo(self.labelSymbol.snp.firstBaseline)
                make.right.equalTo(self.labelChange.snp.left).offset(-model.padding.paddingBetweenX)
            }
            
            self.labelChange.snp.makeConstraints { [unowned self] make in
                make.firstBaseline.equalTo(self.labelSymbol.snp.firstBaseline)
                make.right.equalTo(-model.padding.paddingInnerX)
                make.width.equalTo(50)
            }
            self.layoutSubviews()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


