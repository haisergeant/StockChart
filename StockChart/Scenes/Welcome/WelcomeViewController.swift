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
import Localize_Swift

fileprivate let PaddingInnerX = 20
fileprivate let PaddingInnerY = 8
fileprivate let PaddingOuterY = 20
fileprivate let ImageSize = 90
fileprivate let TitleFontSize = CGFloat(17)
fileprivate let DescriptionFontSize = CGFloat(14)
fileprivate let ButtonHeight = 40

class WelcomeViewController: BaseViewController {
    var router: WelcomeRouterInput!
    let imageViewLogo = UIImageView()
    let labelTitle = UILabel()
    let labelDescription = UILabel()
    let buttonNext = UIButton()
    
    struct Copy {
        static let titleText = "WELCOME_SCREEN_TITLE".localized()
        static let descriptionText = "WELCOME_SCREEN_DESCRIPTION".localized()
        static let buttonTitle = "WELCOME_SCREEN_BUTTON_TITLE".localized()
    }
    
    struct Style {        
        static let titleStyle = StringStyle(.font(UIFont.boldSystemFont(ofSize: TitleFontSize)))
        static let descriptionStyle = StringStyle(.font(UIFont.systemFont(ofSize: DescriptionFontSize)))
    }
    
    override func initialize() {
        self.router = WelcomeRouter(viewController: self)
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        self.view.addSubview(self.imageViewLogo)
        self.view.addSubview(self.labelTitle)
        self.view.addSubview(self.labelDescription)
        self.view.addSubview(self.buttonNext)
        
        self.labelTitle.numberOfLines = 0
        self.labelTitle.attributedText = Copy.titleText.styled(with: Style.titleStyle)
        self.labelTitle.textAlignment = .center
        
        self.labelDescription.numberOfLines = 0
        self.labelDescription.attributedText = Copy.descriptionText.styled(with: Style.descriptionStyle)
        self.labelDescription.textAlignment = .center
        
        self.imageViewLogo.image = UIImage(named: "Logo")
        
        self.buttonNext.layer.cornerRadius = CGFloat(ButtonHeight) * 0.5
        self.buttonNext.setTitle(Copy.buttonTitle, for: .normal)
        self.buttonNext.setTitleColor(.white, for: .normal)
        self.buttonNext.backgroundColor = .darkGray
    }
    
    override func configureLayout() {
        super.configureLayout()
        self.labelDescription.snp.makeConstraints { [unowned self] make in
            make.left.equalTo(PaddingInnerX)
            make.right.equalTo(-PaddingInnerX)
            make.centerY.equalTo(self.view)
        }
        
        self.labelTitle.snp.makeConstraints { [unowned self] make in
            make.bottom.equalTo(self.labelDescription.snp.top).offset(-PaddingInnerY)
            make.left.equalTo(self.labelDescription.snp.left)
            make.right.equalTo(self.labelDescription.snp.right)
        }
        
        self.imageViewLogo.snp.makeConstraints { [unowned self] make in
            make.size.equalTo(ImageSize)
            make.bottom.equalTo(self.labelTitle.snp.top).offset(-PaddingInnerX)
            make.centerX.equalTo(self.view)
        }
        
        self.buttonNext.snp.makeConstraints { make in
            make.left.equalTo(PaddingInnerX)
            make.right.equalTo(-PaddingInnerX)
            make.bottom.equalTo(-PaddingOuterY)
            make.height.equalTo(ButtonHeight)
        }
    }
    
    override func configureActions() {
        super.configureActions()
        self.buttonNext.action { [unowned self] _ in
            self.router.navigateNext()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Animation for logo
        self.imageViewLogo.layer.removeAllAnimations()
        self.imageViewLogo.layer.add(AnimationHelper.rotateAnimation(angle: 360.0, time: 10, repeating: true),
                                     forKey: "rotate")
    }
}
