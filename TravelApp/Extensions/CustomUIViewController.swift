//
//  CustomUIViewController.swift
//  TravelApp
//
//  Created by Angelique Babin on 28/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Custom interface Exchange Rate and Translation
    func customInterface(label: UILabel, textField: UITextField, button: UIButton) {
        customLabel(label: label)
        customTextField(textField: textField)
        customButton(button: button)
    }
    
    // Custom interface Weather
    func customWeatherInterface(allLabels: [UILabel], button: UIButton) {
        for label in allLabels {
            customLabel(label: label)
        }
        customButton(button: button)
    }
    
    // Custom labels
    private func customLabel(label: UILabel) {
        label.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.cornerRadius = 10
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.8
    }
    
    // Custom textFields
    private func customTextField(textField: UITextField) {
        textField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.8
    }
    
    // Custom buttons
    private func customButton(button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.8
    }
}
