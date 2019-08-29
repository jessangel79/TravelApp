//
//  TranslationService.swift
//  TravelApp
//
//  Created by Angelique Babin on 28/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

class TranslationService {
    
    // MARK: Vars
    private var task: URLSessionDataTask?
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    private let baseUrl = "https://translation.googleapis.com/language/translate/v2"
    
    private let languageUrl = "https://translation.googleapis.com/language/translate/v2/languages?target=en&key="
    
    private let keyTranslation = valueForAPIKey(named: "API_GoogleTranslation")

    // MARK: - Methods
    func getTranslate(textToTranslate: String, callBack: @escaping (Bool, Translations?) -> Void) {
        let request = createTranslateRequest(textToTranslate: textToTranslate)
        print(request)
        
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
                
                // MARK: - JSON decodable
                guard let responseJSON = try? JSONDecoder().decode(Translations.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                callBack(true, responseJSON)
            }
        }
        task?.resume()
    }
    
    private func createTranslateRequest(textToTranslate: String) -> URLRequest {
        guard let url = URL(string: baseUrl) else {
            fatalError("Url is not found")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
         let body = "key=\(keyTranslation)&source=fr&target=en&format=text&q=\(textToTranslate)"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
    func getLanguage(callBack: @escaping (Bool, Languages?) -> Void) {
        guard let url = URL(string: languageUrl + keyTranslation) else {
            callBack(false, nil)
            return
        }
        
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
                
                // MARK: - JSON decodable
                guard let responseJSON = try? JSONDecoder().decode(Languages.self, from: data) else {
                    callBack(false, nil)
                    return
                }
                callBack(true, responseJSON)
            }
        }
        task?.resume()
    }

}
