//
//  CoinDelegate.swift
//  ByteCoin
//
//  Created by macbook on 23.11.2023.
//

import Foundation

protocol CoinDelegate: AnyObject {
    func didUpdateCoin(coinManager: CoinManager, coin: CoinData) 
    func didFailWithError(error: Error)
}
