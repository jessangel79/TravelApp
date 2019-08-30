//
//  ExtensionDouble.swift
//  TravelApp
//
//  Created by Angelique Babin on 30/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
