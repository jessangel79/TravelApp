//
//  UIViewController.swift
//  TravelApp
//
//  Created by Angelique Babin on 28/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

// MARK: - Extension to custom labels, buttons, textField and textView

extension UIViewController {
    
    /// custom interface Exchange Rate
    func customInterfaceExchangeRate(label: UILabel, textField: UITextField, button: UIButton) {
        customLabel(label: label)
        customTextField(textField: textField)
        customButton(button: button)
    }
    
    /// custom interface Translation
    func customInterfaceTranslation(textView: UITextView, textField: UITextField, button: UIButton) {
        customTextView(textView: textView)
        customTextField(textField: textField)
        customButton(button: button)
    }
    
    // custom interface Weather
    func customWeatherInterface(allLabels: [UILabel], button: UIButton) {
        for label in allLabels {
            customLabel(label: label)
        }
        customButton(button: button)
    }
    
    // custom labels
    private func customLabel(label: UILabel) {
        label.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.cornerRadius = 10
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.8
    }
    
    // custom textFields
    private func customTextField(textField: UITextField) {
        textField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.8
    }
    
    // custom textViews
    private func customTextView(textView: UITextView) {
        textView.clipsToBounds = false
        textView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textView.layer.cornerRadius = 10
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.8
    }
    
    // custom buttons
    private func customButton(button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.8
    }
}

// MARK: - Extension to manage the ActivityIndicator

extension UIViewController {
    func toggleActivityIndicator(shown: Bool, activityIndicator: UIActivityIndicatorView, validateButton: UIButton) {
        activityIndicator.isHidden = !shown
        validateButton.isHidden = shown
    }
}

// MARK: - Extension to display a alert message to the user

extension UIViewController {
    /// Alert message to user
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
