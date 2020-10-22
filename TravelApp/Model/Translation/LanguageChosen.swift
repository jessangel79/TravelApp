//
//  LanguageChosen.swift
//  TravelApp
//
//  Created by Angelique Babin on 03/09/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

// MARK: - Enumeration of the languages available

enum LanguageChosen: String {
    case french = "fr"
    case english = "en"
    case german = "de"
    
    func language() -> String {
        return self.rawValue
    }
    
    func welcome() -> String {
        guard let languageChosen = LanguageChosen(rawValue: language()) else { return "" }
        
        switch languageChosen {
        case .french:
            return "Bonjour !"
        case .english:
            return "Hello !"
        case .german:
            return "Guten tag !"
        }
    }
    
    func languageSelected() -> String {
        guard let languageChosen = LanguageChosen(rawValue: language()) else { return "" }
        
        switch languageChosen {
        case .french:
            return "French"
        case .english:
            return "English"
        case .german:
            return "German"
        }
    }
}
