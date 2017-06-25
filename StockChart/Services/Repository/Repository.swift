//
//  Repository.swift
//  StockChart
//
//  Created by Le Thanh Hai on 6/25/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit
import ReactiveSwift

protocol Repository {
    func requestStockList(arr: [String]) -> SignalProducer<[Stock], NSError>
}
