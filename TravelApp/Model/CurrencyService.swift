//
//  CurrencyService.swift
//  TravelApp
//
//  Created by Angelique Babin on 06/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

class CurrencyService {

    // MARK: Vars
    static var shared = CurrencyService()
    private init() {}
    private var task: URLSessionDataTask?
    
    private static let currencyUrl = URL(string:
        "http://data.fixer.io/api/symbols?access_key=1398c31984a68b64b7fea3bcb147c54d")!
    
    private static let rateUrl = URL(string:
        "http://data.fixer.io/api/latest?access_key=1398c31984a68b64b7fea3bcb147c54d")!
    
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - Methods
    func getCurrency(callBack: @escaping (Bool, [String]?) -> Void) {

        task?.cancel()
        
        task = session.dataTask(with: CurrencyService.currencyUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return
                }
                
                // MARK: - JSON decodable
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
        
        task?.cancel()
        
        task = session.dataTask(with: CurrencyService.rateUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode ==  200 else {
                    callBack(false, nil)
                    return
                }
                
                // MARK: - JSON decodable
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
