//
//  WeatherAPI.swift
//  TravelApp
//
//  Created by Angelique Babin on 20/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

// MARK: - WeatherAPI

struct WeatherAPI: Decodable {
    let list: [ListDecodable]
}

// MARK: - ListDecodable

struct ListDecodable: Decodable {
    let weather: [WeatherDecodable]
    let main: MainDecodable
    let name: String
}

// MARK: - MainDecodable

struct MainDecodable: Decodable {
    let temp: Double
}

// MARK: - WeatherDecodable

struct WeatherDecodable: Decodable {
    let description: String
}
