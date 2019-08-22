//
//  Rates.swift
//  TravelApp
//
//  Created by Angelique Babin on 06/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

// MARK: - Struct for JSON
struct Rates: Decodable {
    let rates: [String: Double]
}
