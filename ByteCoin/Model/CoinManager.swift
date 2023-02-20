//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Михаил Позялов on 17.02.2023.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateRate(price: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "267CFCF7-A444-46E2-9FB5-2980A4A76152"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    var delegate: CoinManagerDelegate?

    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateRate(price: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let id = decodedData.asset_id_quote
            let rate = decodedData.rate
            
            let coin = CoinModel(rate: rate, currency: id)
            return coin
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
