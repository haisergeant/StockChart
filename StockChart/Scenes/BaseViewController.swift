//
//  BaseViewController.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/22/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configureSubviews()
        self.configureLayout()
        self.configureContent()
        self.configureStyle()
        self.configureActions()
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
