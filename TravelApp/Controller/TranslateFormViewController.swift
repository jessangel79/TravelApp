//
//  TranslateFormViewController.swift
//  TravelApp
//
//  Created by Angelique Babin on 26/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class TranslateFormViewController: UIViewController {

    // MARK: - Properties
    let translationService = TranslationService()
    
    // MARK: - Outlets
    @IBOutlet weak var translationButton: UIButton!
    @IBOutlet weak var textToTranslateLabel: UILabel!
    @IBOutlet weak var languageTranslationLabel: UILabel!
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

// MARK: - Keyboard
extension TranslateFormViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translateTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        translateTextField.resignFirstResponder()
        getTranslation()
        return true
    }
}

// MARK: - Validate
extension TranslateFormViewController {
    @IBAction func tapTranslationButton() {
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, validateButton: translationButton)
        getTranslation()
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        customInterface(label: translationLabel, textField: translateTextField, button: translationButton)
        getLanguages()
    }
    
    // MARK: - Methods
    func getTranslation() {
        guard let textToTranslate = translateTextField?.text else { return }
        
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, validateButton: translationButton)
        
        translationService.getTranslate(textToTranslate: textToTranslate) { (success, translation) in
            self.toggleActivityIndicator(shown: false,
                                         activityIndicator: self.activityIndicator,
                                         validateButton: self.translationButton)
            if success, let translation = translation {
                print(translation)
                self.translationLabel.text = " " + translation.data.translations[0].translatedText
            } else {
                self.presentAlert(message: "The translation failed.")
            }
        }
    }
    
    func getLanguages() {
        translationService.getLanguage { (success, languages) in
            if success, let languages = languages {
                print(languages)
                self.updateLanguage(languages: languages)
            } else {
                self.presentAlert(message: "The language download failed.")
            }
        }
    }
    
    private func updateLanguage(languages: Languages) {
        let languages = languages.data.languages
        for language in languages {
            if language.language == "fr" {
                textToTranslateLabel.text = language.name
            } else if language.language == "en" {
                languageTranslationLabel.text = language.name
//            } else if language.language == "de" {
//                languageTranslationLabel.text = language.name
            }
        }
    }
}
