//
//  StockChartCell.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/28/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit
import BonMot
import SnapKit
import Charts

class GraphView: UIView {
    let leftView = PriceView()
    let rightView = PriceView()
    
    let chartView = LineChartView()
    var contents = [ChartDataEntry]()
    
    struct Style {
        static let LeftBoxStyle = PriceView.Style(titleStyle: StringStyle(.font(UIFont.boldSystemFont(ofSize: 13)),
                                                                          .color(.black), .alignment(.center)),
                                                  priceStyle: StringStyle(.font(UIFont.boldSystemFont(ofSize: 15)),
                                                                          .color(.black), .alignment(.center)),
                                                  backgroundColor: Color.LightBlue)
        static let PositiveBoxStyle = PriceView.Style(titleStyle: StringStyle(.font(UIFont.boldSystemFont(ofSize: 13)),
                                                                              .color(.black), .alignment(.center)),
                                                      priceStyle: StringStyle(.font(UIFont.boldSystemFont(ofSize: 15)),
                                                                              .color(Color.GreenColor), .alignment(.center)),
                                                      backgroundColor: Color.LightBlue)
        static let NegativeBoxStyle = PriceView.Style(titleStyle: StringStyle(.font(UIFont.boldSystemFont(ofSize: 13)),
                                                                              .color(.black), .alignment(.center)),
                                                      priceStyle: StringStyle(.font(UIFont.boldSystemFont(ofSize: 15)),
                                                                              .color(Color.RedColor), .alignment(.center)),
                                                      backgroundColor: Color.LightBlue)
    }
    
    var data: [DayStockViewModel]? {
        didSet {
            self.configureContent()
        }
    }
    
    init(data: [DayStockViewModel]?) {
        self.data = data
        super.init(frame: .zero)
        self.configureSubviews()
        self.configureLayout()
        self.configureContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        self.addSubview(self.chartView)
        self.chartView.chartDescription?.enabled = false
        self.chartView.dragEnabled = true
        self.chartView.setScaleEnabled(true)
        self.chartView.drawGridBackgroundEnabled = false        
        self.chartView.pinchZoomEnabled = false
        
        self.addSubview(self.leftView)
        self.addSubview(self.rightView)
    }
    
    func configureContent() {
        if let data = data {
            self.contents.removeAll()
            for i in 0..<data.count {
                self.contents.append(ChartDataEntry(x: Double(i), y: Double(data[i].stock.askPrice)))
            }
            
            if let first = data.first {
                leftView.title = "CURRENT_PRICE".localized()
                leftView.price = String(first.stock.askPrice)
                leftView.style = Style.LeftBoxStyle
                
                rightView.title = "MOVEMENT".localized()
                rightView.price = first.stock.valueChange
                if let value = Double(first.stock.valueChange) {
                    rightView.style = value > 0.0 ? Style.PositiveBoxStyle : Style.NegativeBoxStyle
                } else {
                    rightView.style = Style.PositiveBoxStyle
                }
                
            }
            
            
            let lineDataSet = LineChartDataSet(values: self.contents, label: nil)
            lineDataSet.setColor(Color.GreenColor)
            lineDataSet.lineWidth = 2.0
            lineDataSet.circleRadius = 3.0
            lineDataSet.mode = .horizontalBezier
            lineDataSet.drawValuesEnabled = false
            lineDataSet.drawCirclesEnabled = false
            lineDataSet.drawFilledEnabled = true
            lineDataSet.fillAlpha = 1.0
            lineDataSet.fillColor = Color.GreenColor
            
            let lineChartData = LineChartData(dataSet: lineDataSet)
            self.chartView.data = lineChartData
            
            let xAxis = self.chartView.xAxis
            xAxis.drawLabelsEnabled = false
            
            let leftAxis = self.chartView.leftAxis
            leftAxis.drawLabelsEnabled = false
            
            let rightAxis = self.chartView.rightAxis
            rightAxis.drawLabelsEnabled = false
        }
    }
    
    func configureLayout() {
        self.leftView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(20)
        }
        
        self.rightView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.right.equalTo(-20)
            make.left.equalTo(self.leftView.snp.right).offset(20)
            make.width.equalTo(self.leftView.snp.width)
            make.height.equalTo(self.leftView.snp.height)
        }
        
        self.chartView.snp.makeConstraints { make in
            make.top.equalTo(self.leftView.snp.bottom).offset(20)
            make.bottom.equalTo(-20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(150)
        }
    }
}

class StockChartCell: UITableViewCell {
    var labelDate = UILabel()
    var labelSymbol = UILabel()
    var labelPrice = UILabel()
    var labelChange = UILabel()
    
    var upperArea = UIView()
    var lowerArea = UIView()
    let separator = UIView()
    
    init() {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: "StockViewCell")
        self.configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        self.contentView.addSubview(self.upperArea)
        self.upperArea.addSubview(self.labelDate)
        self.upperArea.addSubview(self.labelSymbol)
        self.upperArea.addSubview(self.labelPrice)
        self.upperArea.addSubview(self.labelChange)
        
        self.contentView.addSubview(self.lowerArea)
        self.contentView.addSubview(self.separator)
    }
    
    func configure(model: AnyObject) {
        if let model = model as? DayStockViewModel {
            self.labelDate.attributedText = model.day
            self.labelDate.numberOfLines = 0
            self.labelSymbol.attributedText = model.labelTitle
            self.labelChange.attributedText = model.changeText
            self.labelPrice.attributedText = model.priceText
            self.separator.backgroundColor = Color.SeparatorColor
            
            self.upperArea.snp.makeConstraints { make in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(0)
            }
            
            self.lowerArea.snp.makeConstraints { make in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(self.upperArea.snp.bottom).offset(0)
                make.bottom.equalTo(self.separator.snp.top)
            }
            
            self.separator.snp.makeConstraints { make in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(0)
                make.height.equalTo(1)
            }
            
            self.labelDate.snp.makeConstraints { make in
                make.left.equalTo(model.padding.paddingInnerX)
                make.top.equalTo(model.padding.paddingInnerY)
                make.bottom.equalTo(-model.padding.paddingInnerY)
            }
            self.labelDate.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
            
            self.labelSymbol.snp.makeConstraints { [unowned self] make in
                make.left.equalTo(self.labelDate.snp.right).offset(model.padding.paddingBetweenX)
                make.top.equalTo(model.padding.paddingInnerY)
                make.bottom.equalTo(-model.padding.paddingInnerY)
                make.right.equalTo(self.labelPrice.snp.left).offset(-model.padding.paddingBetweenX)
            }
            
            self.labelPrice.snp.makeConstraints { [unowned self] make in
                // make.firstBaseline.equalTo(self.labelSymbol.snp.firstBaseline)
                make.centerY.equalTo(self.upperArea)
                make.right.equalTo(self.labelChange.snp.left).offset(-model.padding.paddingBetweenX)
            }
            
            self.labelChange.snp.makeConstraints { [unowned self] make in
                // make.firstBaseline.equalTo(self.labelSymbol.snp.firstBaseline)
                make.centerY.equalTo(self.upperArea)
                make.right.equalTo(-model.padding.paddingInnerX)
                make.width.equalTo(50)
            }
            
            var prevView: UIView? = nil
            for item in model.items {
                let priceView = PriceView(title: item.title, price: item.price)
                self.lowerArea.addSubview(priceView)
                
                if prevView == nil {
                    priceView.snp.makeConstraints { make in
                        make.left.equalTo(self.lowerArea)
                        make.top.equalTo(self.lowerArea)
                        make.bottom.equalTo(self.lowerArea)
                    }
                } else if let prevView = prevView {
                    priceView.snp.makeConstraints { make in
                        make.left.equalTo(prevView.snp.right)
                        make.top.equalTo(self.lowerArea)
                        make.bottom.equalTo(self.lowerArea)
                        make.width.equalTo(prevView.snp.width)
                    }
                }
                prevView = priceView
            }
            prevView?.snp.makeConstraints { make in
                make.right.equalTo(self.lowerArea)
            }
            
            if model.selected.value {
                self.lowerArea.heightContraint?.remove()
                self.lowerArea.isHidden = false
            } else {
                self.lowerArea.snp.makeConstraints { make in
                    make.height.equalTo(0).priority(.required)
                }
                self.lowerArea.isHidden = true
            }
            self.layoutSubviews()
        }
    }
}

class PriceView: UIView {
    var labelTitle = UILabel()
    var labelPrice = UILabel()
    
    struct Style {
        var titleStyle: StringStyle
        var priceStyle: StringStyle
        var backgroundColor: UIColor
        init(titleStyle: StringStyle = StringStyle(.font(UIFont.boldSystemFont(ofSize: 9)),
                                                   .color(.white),
                                                   .alignment(.center)),
             priceStyle: StringStyle = StringStyle(.font(UIFont.boldSystemFont(ofSize: 13)),
                                                   .color(.white),
                                                   .alignment(.center)),
             backgroundColor: UIColor = .lightGray) {
            self.titleStyle = titleStyle
            self.priceStyle = priceStyle
            self.backgroundColor = backgroundColor
        }
    }
    
    var title: String {
        didSet {
            self.configureContent()
            self.layoutIfNeeded()
        }
    }
    
    var price: String {
        didSet {
            self.configureContent()
            self.layoutIfNeeded()
        }
    }
    
    var style: Style {
        didSet {
            self.configureContent()
        }
    }
    
    init(title: String = "", price: String = "",
         style: Style = Style(), padding: Padding = Padding(paddingInnerX: 5.0,
                                                            paddingInnerY: 10.0,
                                                            paddingBetweenX: 5.0,
                                                            paddingBetweenY: 5.0)) {
        self.title = title
        self.price = price
        self.style = style
        super.init(frame: .zero)

        self.configureSubviews()
        self.configureLayout(padding: padding)
        self.configureContent()
    }
    
    func configureSubviews() {
        self.addSubview(self.labelTitle)
        self.addSubview(self.labelPrice)
    }
    
    func configureContent() {
        self.labelTitle.attributedText = title.styled(with: style.titleStyle)
        self.labelPrice.attributedText = price.styled(with: style.priceStyle)
        self.backgroundColor = style.backgroundColor
    }
    
    func configureLayout(padding: Padding) {
        self.labelTitle.snp.makeConstraints { make in
            make.top.equalTo(padding.paddingInnerY)
            make.centerX.equalTo(self)
        }
        
        self.labelPrice.snp.makeConstraints { make in
            make.top.equalTo(self.labelTitle.snp.bottom).offset(padding.paddingBetweenY)
            make.centerX.equalTo(self)
            make.left.equalTo(padding.paddingInnerX)
            make.right.equalTo(-padding.paddingInnerX)
            make.bottom.equalTo(-padding.paddingInnerY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
