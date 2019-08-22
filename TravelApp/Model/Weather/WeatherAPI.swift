//
//  WeatherAPI.swift
//  TravelApp
//
//  Created by Angelique Babin on 20/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

// MARK: - Struct for JSON
struct WeatherAPI: Decodable {
    let list: [ListDecodable]
}

struct ListDecodable: Decodable {
    let weather: [WeatherDecodable]
    let main: MainDecodable
    let name: String
}

struct MainDecodable: Decodable {
    let temp: Double
}

struct WeatherDecodable: Decodable {
    let description: String
}
