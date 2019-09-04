//
//  LanguageChosen.swift
//  TravelApp
//
//  Created by Angelique Babin on 03/09/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

enum LanguageChosen: String {
    case french = "fr"
    case english = "en"
    
    func language() -> String {
        return self.rawValue
    }
    
    func welcome() -> String {
        guard let languageChosen = LanguageChosen(rawValue: language()) else {
            return ""
        }
        switch languageChosen {
        case .french:
            return "Bonjour !"
        case .english:
            return "Hello !"
        }
    }
}
