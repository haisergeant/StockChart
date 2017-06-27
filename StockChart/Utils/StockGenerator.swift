//
//  StockGenerator.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/27/17.
//  Copyright © 2017 haile. All rights reserved.
//

import Foundation

fileprivate let NumberOfDays = 20

class StockGenerator {
    static let instance = StockGenerator()
    
    func generateStock(stock: Stock) -> [Stock] {
        var array = [Stock]()
        
        let date = Date()
        let calendar = Calendar.current
        for i in 0..<NumberOfDays {            
            let number = self.random(value: stock.askPrice)
            let stock = Stock(symbol: stock.symbol, askPrice: number,
                              valueChange: stock.valueChange, openValue: number,
                              highValue: number + stock.askPrice * 0.1, lowValue: number,
                              marketCap: stock.marketCap)
            if let day = calendar.date(byAdding: .day, value: -i, to: date) {
                stock.date = day
            }            
            array.append(stock)
        }
        
        return array
    }
    
    private func random(value: Float, range: Int = 10) -> Float {
        return (Float(arc4random_uniform(UInt32(range))) + value)
    }
}
