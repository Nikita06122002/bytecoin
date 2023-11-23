//
//  CoinManager.swift
//  ByteCoin
//
//  Created by macbook on 23.11.2023.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "DE6AB68C-B1FE-4445-B903-4998DDCB0D89"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    weak var delegate: CoinDelegate?
    
    func fetchCoin(for name: String) {
        let stringURL = "\(baseURL)/\(name)?apikey=\(apiKey)"
        performRequest(with: stringURL)
    }
    
    func performRequest(with URLString: String) {
        if let url = URL(string: URLString) {
            //create URLSession
            let session = URLSession(configuration: .default)
            //Task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safedData = data {
                    if let coin = parseJSON(safedData) {
                        self.delegate?.didUpdateCoin(coinManager: self, coin: coin)
                    }
                }
            }
            //Start task
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            let coin = CoinData(rate: rate)
            return coin
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
