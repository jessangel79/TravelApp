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
        
        task = session.dataTask(with: request as URLRequest,
                                        completionHandler: { (data, response, error) -> Void in
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
        })
        task?.resume()
    }
    
    private func createTranslationRequest(textToTranslate: String,
                                          target: String,
                                          source: String) -> NSMutableURLRequest? {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "accept-encoding": "application/gzip",
            "x-rapidapi-host": "google-translate1.p.rapidapi.com",
            "x-rapidapi-key": keyTranslation
        ]

        let encodingUtf8 = String.Encoding.utf8
        let postData = NSMutableData(data: "q=\(textToTranslate)".data(using: encodingUtf8) ?? Data())
        postData.append("&source=\(source)".data(using: encodingUtf8) ?? Data())
        postData.append("&target=\(target)".data(using: encodingUtf8) ?? Data())

        guard let url = NSURL(string: "https://rapidapi.p.rapidapi.com/language/translate/v2") else { return nil }
        let request = NSMutableURLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        return request
    }

    /// network call to get the languages
    func getLanguage(callBack: @escaping (Bool, Languages?) -> Void) {
        guard let request =  createLanguageRequest() else { return }
        
        task?.cancel()

        task = session.dataTask(with: request as URLRequest,
                                        completionHandler: { (data, response, error) -> Void in
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
        })
        task?.resume()

    }
    
    private func createLanguageRequest() -> NSMutableURLRequest? {
        let headers = [
            "accept-encoding": "application/gzip",
            "x-rapidapi-host": "google-translate1.p.rapidapi.com",
            "x-rapidapi-key": keyTranslation
        ]
        guard let url = NSURL(
                string: "https://rapidapi.p.rapidapi.com/language/translate/v2/languages"
        ) else { return nil }
        let request = NSMutableURLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
}
