//
//  WeatherService.swift
//  TravelApp
//
//  Created by Angelique Babin on 20/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

class WeatherService {
    
    // MARK: - Vars
    
    private var task: URLSessionDataTask?
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    private let baseUrl = "http://api.openweathermap.org/data/2.5/group?id=3035864,5128638&units=metric&APPID="
    
    private let keyWeather = valueForAPIKey(named: "API_OpenWeathermap")
    
    // MARK: - Methods
    
    /// network call to get the weather
    func getWeather(callBack: @escaping (Bool, WeatherAPI?) -> Void) {
        guard let url = URL(string: baseUrl + keyWeather) else { return }
        
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
                guard let responseJSON = try? JSONDecoder().decode(WeatherAPI.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                callBack(true, responseJSON)
            }
        }
        task?.resume()
    }
}
