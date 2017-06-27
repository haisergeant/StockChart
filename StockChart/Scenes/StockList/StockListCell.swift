//
//  StockListCell.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/28/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit
import SnapKit

class StockViewCell: UITableViewCell {
    let labelSymbol = UILabel()
    let labelPrice = UILabel()
    let labelChange = UILabel()
    let separator = UIView()
    
    init() {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: "StockViewCell")
        self.configureSubviews()
    }
    
    func configureSubviews() {
        self.contentView.addSubview(self.labelSymbol)
        self.contentView.addSubview(self.labelPrice)
        self.contentView.addSubview(self.labelChange)
        self.contentView.addSubview(self.separator)
    }
    
    func configure(model: AnyObject) {
        if let model = model as? StockViewModel {
            self.labelSymbol.attributedText = model.labelTitle
            self.labelChange.attributedText = model.changeText
            self.labelPrice.attributedText = model.priceText
            self.separator.backgroundColor = Color.SeparatorColor
            
            self.separator.snp.makeConstraints { make in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(0)
                make.height.equalTo(1)
            }
            
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


