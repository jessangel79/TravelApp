//
//  TranslationServiceTestCase.swift
//  TravelAppTests
//
//  Created by Angelique Babin on 30/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import XCTest
@testable import TravelApp

class TranslationServiceTestCase: XCTestCase {

    // MARK: - Tests getTranslation
    
    func testGetTranslationShouldPostFailedCallbackIfError() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let textToTranslate = "Un chat"
        let target = "en"
        let source = "fr"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: textToTranslate,
                                          target: target,
                                          source: source) { (success, translation) in
                                            // Then
                                            XCTAssertFalse(success)
                                            XCTAssertNil(translation)
                                            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallBackIfNoData() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let textToTranslate = "Un chat"
        let target = "en"
        let source = "fr"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: textToTranslate,
                                          target: target,
                                          source: source) { (success, translation) in
                                            // Then
                                            XCTAssertFalse(success)
                                            XCTAssertNil(translation)
                                            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: FakeResponseData.translationInEnglishCorrectData,
                                    response: FakeResponseData.responseKO,
                                    error: nil))
        
        // When
        let textToTranslate = "Un chat"
        let target = "en"
        let source = "fr"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: textToTranslate,
                                          target: target,
                                          source: source) { (success, translation) in
                                            // Then
                                            XCTAssertFalse(success)
                                            XCTAssertNil(translation)
                                            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallBackIfIncorrectData() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: FakeResponseData.incorrectData,
                                    response: FakeResponseData.responseOK,
                                    error: nil))
        
        // When
        let textToTranslate = "Un chat"
        let target = "en"
        let source = "fr"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: textToTranslate,
                                          target: target,
                                          source: source) { (success, translation) in
                                            // Then
                                            XCTAssertFalse(success)
                                            XCTAssertNil(translation)
                                            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Tests getTranslation - When all Ok
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: FakeResponseData.translationInEnglishCorrectData,
                                    response: FakeResponseData.responseOK,
                                    error: nil))
        
        // When
        let textToTranslate = "Un chat"
        let target = "en"
        let source = "fr"
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: textToTranslate,
                                          target: target,
                                          source: source) { (success, translation) in
                                            // Then
                                            XCTAssertTrue(success)
                                            XCTAssertNotNil(translation)
                                            let translationTest = "A cat"
                                            XCTAssertEqual(translationTest,
                                                           translation?.data.translations[0].translatedText)
                                            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Tests getLanguage
    
    func testGetLanguageShouldPostFailedCallbackIfError() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getLanguage { (success, languages) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguageShouldPostFailedCallBackIfNoData() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getLanguage { (success, languages) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguageShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: FakeResponseData.languageCorrectData,
                                    response: FakeResponseData.responseKO,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getLanguage { (success, languages) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguageShouldPostFailedCallBackIfIncorrectData() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: FakeResponseData.incorrectData,
                                    response: FakeResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getLanguage { (success, languages) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    // Tests getLanguage - When all Ok
    func testGetLanguageShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: FakeResponseData.languageCorrectData,
                                    response: FakeResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getLanguage { (success, languages) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(languages)
            
            let languageTextToTranslate = "fr"
            let languageTranslation = "en"
            var nameTextToTranslateTest = ""
            var nameTranslationTest = ""
            let languageTextToTranslateTest = "French"
            let languageTranslationTest = "English"
            guard let languagesArray = languages?.data.languages else { return }
            for language in languagesArray {
                if language.language == languageTextToTranslate {
                    nameTextToTranslateTest = language.name
                }
                if language.language == languageTranslation {
                    nameTranslationTest = language.name
                }
            }
            
            XCTAssertEqual(nameTextToTranslateTest, languageTextToTranslateTest)
            XCTAssertEqual(nameTranslationTest, languageTranslationTest)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}
