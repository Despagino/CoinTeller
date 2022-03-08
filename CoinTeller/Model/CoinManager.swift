//
//  CoinManager.swift
//  CoinTeller
//
//  Created by Gino Tasis on 3/7/22.
//

import Foundation
import CoreLocation

protocol CoinManagerDelegate {
    
    func didFailWithError(error: Error)
    func didUpdateCoin(self, coin: coin)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E321659F-E0DA-480B-A72F-65B7C5E01338"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR", "PHP"]
    
    var delegate: CoinManagerDelegate?

    func performRequest(_ urlString: String) {
        
        //1. create URL
        if let url = URL(string: urlString) {
        
        //2. create a URL session
        let session = URLSession(configuration: .default)
            
        // 3. Give session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error! )
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoin(self, coin: coin)
                    }
                }
            }
            
        // 4. Start the task
        task.resume()
        }
    }
    
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
        let decodedData = try decoder.decode(ClimateData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = ClimateModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }

    
    
}
