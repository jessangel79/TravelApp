//
//  Translations.swift
//  TravelApp
//
//  Created by Angelique Babin on 26/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

// MARK: - Translations
struct Translations: Decodable {
    let data: TranslationData
}

// MARK: - TranslationData
struct TranslationData: Decodable {
    let translations: [TranslationText]
}

// MARK: - TranslationText
struct TranslationText: Decodable {
    let translatedText: String
}
