//
//  WelcomeViewController.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/22/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit
import SnapKit
import BonMot

fileprivate let PaddingInnerX = 20
fileprivate let PaddingInnerY = 8
fileprivate let PaddingOuterY = 20
fileprivate let ImageSize = 90
fileprivate let TitleFontSize = 14
fileprivate let DescriptionFontSize = 13
fileprivate let ButtonHeight = 40

class WelcomeViewController: BaseViewController {
    let imageViewLogo = UIImageView()
    let labelTitle = UILabel()
    let labelDescription = UILabel()
    let buttonNext = UIButton()
    
    struct Copy {
        // TODO: add text here
    }
    
    struct Style {
        // TODO: add Style here

    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        self.view.addSubview(self.imageViewLogo)
        self.view.addSubview(self.labelTitle)
        self.view.addSubview(self.labelDescription)
        self.view.addSubview(self.buttonNext)
        
        self.labelTitle.numberOfLines = 0
        // TODO: add localize here
        self.labelTitle.text = "Stock APP"
        self.labelTitle.textAlignment = .center
        
        self.labelDescription.numberOfLines = 0
        // TODO: add localize here
        self.labelDescription.text = "Get real insights about the stocks you've invested in"
        self.labelDescription.textAlignment = .center
        
        self.imageViewLogo.image = UIImage(named: "Logo")
        
        self.buttonNext.layer.cornerRadius = CGFloat(ButtonHeight) * 0.5
        self.buttonNext.setTitle("Next", for: .normal)
        self.buttonNext.setTitleColor(.white, for: .normal)
        self.buttonNext.backgroundColor = .darkGray
    }
    
    override func configureLayout() {
        super.configureLayout()
        self.labelDescription.snp.makeConstraints { [unowned self] (make) in
            make.left.equalTo(PaddingInnerX)
            make.right.equalTo(-PaddingInnerX)
            make.centerY.equalTo(self.view)
        }
        
     
        self.labelTitle.snp.makeConstraints { [unowned self] (make) in
            make.bottom.equalTo(self.labelDescription.snp.top).offset(-PaddingInnerY)
            make.left.equalTo(self.labelDescription.snp.left)
            make.right.equalTo(self.labelDescription.snp.right)
        }
        
        self.imageViewLogo.snp.makeConstraints { [unowned self] (make) in
            make.size.equalTo(ImageSize)
            make.bottom.equalTo(self.labelTitle.snp.top).offset(-PaddingInnerX)
            make.centerX.equalTo(self.view)
        }
        
        self.buttonNext.snp.makeConstraints { (make) in
            make.left.equalTo(PaddingInnerX)
            make.right.equalTo(-PaddingInnerX)
            make.bottom.equalTo(-PaddingOuterY)
            make.height.equalTo(ButtonHeight)
        }
    }
    
    override func configureActions() {
        super.configureActions()
        self.buttonNext.action { [unowned self] _ in
            
        }
    }
    
}
