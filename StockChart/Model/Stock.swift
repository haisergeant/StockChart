//
//  Stock.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/25/17.
//  Copyright © 2017 haile. All rights reserved.
//

import Foundation

class Stock {
    var symbol: String = ""
    var askPrice: Float = 0
    var valueChange: String = ""
    
    var openValue: Float = 0
    var highValue: Float = 0
    var lowValue: Float = 0
    var marketCap: String = ""
    
    init(symbol: String, askPrice: Float, valueChange: String,
         openValue: Float, highValue: Float, lowValue: Float,
         marketCap: String) {
        self.symbol = symbol
        self.askPrice = askPrice
        self.valueChange = valueChange
        self.openValue = openValue
        self.highValue = highValue
        self.lowValue = lowValue
        self.marketCap = marketCap
    }
    
    init(dictionary: [String: AnyObject]) {
        if let value = dictionary["Symbol"] as? String {
            self.symbol = value
        }
        if let value = dictionary["Bid"] as? String, let num = Float(value) {
            self.askPrice = num
        }
        if let value = dictionary["Change"] as? String {
            self.valueChange = value
        }
        
        if let value = dictionary["Open"] as? String, let num = Float(value) {
            self.openValue = num
        }
        if let value = dictionary["DaysHigh"] as? String, let num = Float(value) {
            self.highValue = num
        }
        if let value = dictionary["DaysLow"] as? Float {
            self.lowValue = value
        }
        if let value = dictionary["MarketCapitalization"] as? String {
            self.marketCap = value
        }        
    }
}
