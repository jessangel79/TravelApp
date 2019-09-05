//
//  CurrencyService.swift
//  TravelApp
//
//  Created by Angelique Babin on 06/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

class CurrencyService {

    // MARK: - Vars
    
    private var task: URLSessionDataTask?
    
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    private let currencyUrl = "http://data.fixer.io/api/symbols?access_key="
    private let rateUrl = "http://data.fixer.io/api/latest?access_key="
    private let keyExchange = valueForAPIKey(named: "API_Fixer")
    
    // MARK: - Methods
    
    func getCurrency(callBack: @escaping (Bool, [String]?) -> Void) {
        guard let url = URL(string: currencyUrl + keyExchange) else { return }

        task?.cancel()
        
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return
                }
                
                // JSON decodable
                guard let responseJSON = try? JSONDecoder().decode(Currency.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                let symbolsJSON = responseJSON.symbols.map({(symbol, _) in symbol})
                callBack(true, symbolsJSON)
            }
        }
        task?.resume()
    }
    
    func getRate(symbol: String, callBack: @escaping (Bool, Double?) -> Void) {
        guard let url = URL(string: rateUrl + keyExchange) else { return }
        
        task?.cancel()
        
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode ==  200 else {
                    callBack(false, nil)
                    return
                }
                
                // JSON decodable
                guard let responseJSON = try? JSONDecoder().decode(Rates.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                let ratesJSON = responseJSON.rates[symbol]
                callBack(true, ratesJSON)
            }
        }
        task?.resume()
    }
}
