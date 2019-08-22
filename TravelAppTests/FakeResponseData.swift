//
//  FakeResponseData.swift
//  TravelAppTests
//
//  Created by Angelique Babin on 08/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    // Correct data for the method getCurrency
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Currency", withExtension: "json") else {
            fatalError("Currency.json is not found.")
        }
        return try? Data(contentsOf: url)
    }
    
    // Correct data for the method getRate
    static var ratesCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Rates", withExtension: "json") else {
            fatalError("Rates.json is not found.")
        }
        return try? Data(contentsOf: url)
    }
    
    // Correct data for the method getWeather
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Weather", withExtension: "json") else {
            fatalError("Weather.json is not found.")
        }
        return try? Data(contentsOf: url)
    }
    
    // Incorrect data for the method getCurrency
    static let currencyIncorrectData = "error".data(using: .utf8)!
    
    // Incorrect data for the method getRate
    static let ratesIncorrectData = "12.457".data(using: .utf8)!
    
    // Incorrect data for the method getWeather
    static let weatherIncorrectData = "error".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    class AllError: Error {}
    static let error = AllError()
}