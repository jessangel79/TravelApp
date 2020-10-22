//
//  WeatherServiceTestCase.swift
//  TravelAppTests
//
//  Created by Angelique Babin on 22/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import XCTest
@testable import TravelApp

class WeatherServiceTestCase: XCTestCase {
    
    // MARK: - Tests getWeather
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, weather) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfNoData() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, weather) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeResponseData.weatherCorrectData,
                                    response: FakeResponseData.responseKO,
                                    error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, weather) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeResponseData.incorrectData,
                                    response: FakeResponseData.responseOK,
                                    error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, weather) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Tests getCurrency - When all Ok
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeResponseData.weatherCorrectData,
                                    response: FakeResponseData.responseOK,
                                    error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, weather) in
            
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            let responseCityNY = "New York"
            let responseTempNY = 22.57
            let responseConditionNY = "broken clouds"
            let responseCityAuvers = "Auvers-sur-Oise"
            let responseTempAuvers = 26.38
            let responseConditionAuvers = "clear sky"
            let weatherNY = weather?.list[1]
            let weatherAuvers = weather?.list[0]
            XCTAssertEqual(responseCityNY, weatherNY?.name)
            XCTAssertEqual(responseTempNY, weatherNY?.main.temp)
            XCTAssertEqual(responseConditionNY, weatherNY?.weather[0].description)
            XCTAssertEqual(responseCityAuvers, weatherAuvers?.name)
            XCTAssertEqual(responseTempAuvers, weatherAuvers?.main.temp)
            XCTAssertEqual(responseConditionAuvers, weatherAuvers?.weather[0].description)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
