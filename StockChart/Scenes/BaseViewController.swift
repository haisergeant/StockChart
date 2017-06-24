//
//  BaseViewController.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/22/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() { }
    func navigationTitle() -> String { return "" }
    
    func shouldShowNavigationBar() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.navigationTitle()
        self.view.backgroundColor = .white
        self.configureSubviews()
        self.configureLayout()
        self.configureContent()
        self.configureStyle()
        self.configureActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(!self.shouldShowNavigationBar(), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureSubviews() { }
    func configureLayout() { }
    func configureContent() { }
    func configureStyle() { }
    func configureActions() { }
}
