//
//  Languages.swift
//  TravelApp
//
//  Created by Angelique Babin on 26/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

// MARK: - Languages
struct Languages: Decodable {
    let data: LanguageData
}

// MARK: - LanguageData
struct LanguageData: Decodable {
    let languages: [Language]
}

// MARK: - Language
struct Language: Decodable {
    let language, name: String
}
