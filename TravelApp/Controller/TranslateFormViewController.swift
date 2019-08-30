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
    @IBOutlet weak var choiceLanguageSegmentedControl: UISegmentedControl!
}

// MARK: - Keyboard
extension TranslateFormViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translateTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        translateTextField.resignFirstResponder()
        choiceLanguage()
        return true
    }
}

// MARK: - Validate
extension TranslateFormViewController {
    @IBAction func tapTranslationButton() {
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, validateButton: translationButton)
        choiceLanguage()
    }
    
    @IBAction func choiceLanguageSelected(_ sender: Any) {
        switch choiceLanguageSegmentedControl.selectedSegmentIndex {
        case 0:
            refreshText(translateBase: "Bonjour !",
                        translationBase: " Hello !",
                        textToTranslate: "fr",
                        translation: "en")
        case 1:
            refreshText(translateBase: "Hello !",
                        translationBase: " Bonjour !",
                        textToTranslate: "en",
                        translation: "fr")
        default:
            presentAlert(message: "An error occurred")
        }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        customInterface(label: translationLabel, textField: translateTextField, button: translationButton)
        getLanguages(textToTranslate: "fr", translation: "en")
    }
    
    // MARK: - Methods
    // to translate french in english
    func getTranslationInEnglish() {
        guard let textToTranslate = translateTextField?.text else { return }
        
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, validateButton: translationButton)
        
        translationService.getTranslateInEnglish(textToTranslate: textToTranslate) { (success, translation) in
            self.toggleActivityIndicator(shown: false,
                                         activityIndicator: self.activityIndicator,
                                         validateButton: self.translationButton)
            if success, let translation = translation {
                print(translation)
                self.translationLabel.text = " " + translation.data.translations[0].translatedText
            } else {
                self.presentAlert(message: "The translation download failed.")
            }
        }
    }
    
    // to translate english in french
    func getTranslationInFrench() {
        guard let textToTranslate = translateTextField?.text else { return }
        
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, validateButton: translationButton)
        
        translationService.getTranslateInFrench(textToTranslate: textToTranslate) { (success, translation) in
            self.toggleActivityIndicator(shown: false,
                                         activityIndicator: self.activityIndicator,
                                         validateButton: self.translationButton)
            if success, let translation = translation {
                print(translation)
                self.translationLabel.text = " " + translation.data.translations[0].translatedText
            } else {
                self.presentAlert(message: "The translation download failed.")
            }
        }
    }
    
    // get the language
    func getLanguages(textToTranslate: String, translation: String) {
        translationService.getLanguage { (success, languages) in
            if success, let languages = languages {
                print(languages)
                self.updateLanguage(languages: languages, textToTranslate: textToTranslate, translation: translation)
            } else {
                self.presentAlert(message: "The language download failed.")
            }
        }
    }
    
    // display the languages
    private func updateLanguage(languages: Languages, textToTranslate: String, translation: String) {
        let languages = languages.data.languages
        for language in languages {
            if language.language == textToTranslate {
                textToTranslateLabel.text = language.name
            }
            if language.language == translation {
                languageTranslationLabel.text = language.name
            }
        }
    }
    
    // choice the translation in english or in french
    private func choiceLanguage() {
        switch choiceLanguageSegmentedControl.selectedSegmentIndex {
        case 0:
            getTranslationInEnglish()
        case 1:
            getTranslationInFrench()
        default:
            presentAlert(message: "An error occurred.")
        }
    }

    private func refreshText(translateBase: String,
                             translationBase: String,
                             textToTranslate: String,
                             translation: String) {
        translateTextField.text = String()
        translateTextField.placeholder = translateBase
        translationLabel.text = translationBase
        getLanguages(textToTranslate: textToTranslate, translation: translation)
    }
}
