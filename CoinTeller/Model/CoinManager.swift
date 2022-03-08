//
//  CoinManager.swift
//  CoinTeller
//
//  Created by Gino Tasis on 3/7/22.
//

import Foundation

protocol CoinManagerDelegate {
    
    func displayData(price: String, currency: String)
    
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E321659F-E0DA-480B-A72F-65B7C5E01338"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR", "PHP"]
    
    var delegate: CoinManagerDelegate?
    
    // MARK: - getting the Data calling the API call
    
    func getCoinPrice(for currency: String) {
    
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            
            // create URLSession object
            let session = URLSession(configuration: .default)
            
            // create new data task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                //Format the data that we get back
                if let safeData = data {
                    if let btcPrice = self.parseJSON(safeData) {
                        let priceString = String(format: "%.2f", btcPrice)
                        
                        self.delegate?.displayData(price: priceString, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Parsing the JSON data that we get
    
    func parseJSON(_ data: Data) -> Double? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let price = decodedData.rate
            return price        }
        catch {
            
            print(error)
            return nil
            
        }
    }
    
}
