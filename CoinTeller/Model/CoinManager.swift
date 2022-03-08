//
//  CoinManager.swift
//  CoinTeller
//
//  Created by Gino Tasis on 3/7/22.
//

import Foundation
import CoreLocation


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E321659F-E0DA-480B-A72F-65B7C5E01338"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR", "PHP"]
    
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
                let dataToString = String(data: data!, encoding: .utf8)
                print(dataToString!)
            }
            task.resume()
        }
        
        
    }
    


    
    
}
