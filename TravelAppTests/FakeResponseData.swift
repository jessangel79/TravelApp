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
    
    // Correct data for the method getTranslation in English
    static var translationInEnglishCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "TranslationsInEnglish", withExtension: "json") else {
            fatalError("TranslationsInEnglish.json is not found.")
        }
        return try? Data(contentsOf: url)
    }
    
    // Correct data for the method getLanguage
    static var languageCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Languages", withExtension: "json") else {
            fatalError("Languages.json is not found.")
        }
        return try? Data(contentsOf: url)
    }
    
    // Incorrect data for all JSON
    static let incorrectData = "error".data(using: .utf8)!
    
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
