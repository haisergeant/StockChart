//
//  ServerRepository.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/25/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit
import ReactiveSwift
import Alamofire

fileprivate let STOCK_URL = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in(SYMBOL_LIST)&format=json&diagnostics=true&env=store://datatables.org/alltableswithkeys&callback="

class ServerRepository: Repository {
    static let instance = ServerRepository()
    func requestStockList(arr: [String]) -> SignalProducer<[Stock], NSError> {
        return SignalProducer { observer, disposable in
            if let symbolString = arr.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) {
                let urlString = STOCK_URL.replacingOccurrences(of: "SYMBOL_LIST", with: symbolString)
                let request = Alamofire.request(urlString).responseJSON { response in
                    if let resultDict = response.result.value as? NSDictionary {
                        if let query = resultDict.object(forKey: "query") as? NSDictionary {
                            if let results = query.object(forKey: "results") as? NSDictionary {
                                var stocks = [Stock]()
                                if let quote = results.object(forKey: "quote") as? NSDictionary {
                                    // only has one symbol
                                    stocks.append(Stock(dictionary: quote as! [String : AnyObject]))
                                } else if let quotes = results.object(forKey: "quote") as? NSArray {
                                    // has multiple symbols
                                    for quote in quotes {
                                        stocks.append(Stock(dictionary: quote as! [String : AnyObject]))
                                    }
                                }
                                
                                observer.send(value: stocks)
                                observer.sendCompleted()
                            }
                        }
                    }
                }
                
                _ = disposable.add {
                    request.cancel()
                }
            }
        }
    }
}
