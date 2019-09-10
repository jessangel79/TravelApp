//
//  TranslationService.swift
//  TravelApp
//
//  Created by Angelique Babin on 28/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

class TranslationService {
    
    // MARK: - Vars

    private var task: URLSessionDataTask?
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    private let baseUrl = "https://translation.googleapis.com/language/translate/v2"
    
    private let keyTranslation = valueForAPIKey(named: "API_GoogleTranslation")

    // MARK: - Methods

    /// network call to get the translation
    func getTranslation(textToTranslate: String,
                        target: String,
                        source: String,
                        callBack: @escaping (Bool, Translations?) -> Void) {
        guard let request = createTranslationRequest(textToTranslate: textToTranslate,
                                                     target: target,
                                                     source: source) else { return }
        
        task?.cancel()
        
        task = session.dataTask(with: request) { (data, response, error) in
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
                guard let responseJSON = try? JSONDecoder().decode(Translations.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                callBack(true, responseJSON)
            }
        }
        task?.resume()
    }
    
    private func createTranslationRequest(textToTranslate: String, target: String, source: String) -> URLRequest? {
        guard let url = URL(string: baseUrl) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = "key=\(keyTranslation)&source=\(source)&target=\(target)&format=text&q=\(textToTranslate)"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
    /// network call to get the languages
    func getLanguage(callBack: @escaping (Bool, Languages?) -> Void) {
        guard let url = createLanguageUrl() else { return }
        
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
                guard let responseJSON = try? JSONDecoder().decode(Languages.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                callBack(true, responseJSON)
            }
        }
        task?.resume()
    }

    private func createLanguageUrl() -> URL? {
        let languageUrl = "/languages?key=\(keyTranslation)&target=en"
        guard let url = URL(string: baseUrl + languageUrl) else { return nil }
        return url
    }
}
