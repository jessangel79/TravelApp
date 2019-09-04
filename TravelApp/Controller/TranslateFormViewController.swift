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
    private let frenchWelcome = LanguageChosen.french.welcome()
    private let frenchLanguage = LanguageChosen.french.language()
    private let englishWelcome = LanguageChosen.english.welcome()
    private let englishLanguage = LanguageChosen.english.language()
    
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
        choiceLanguageToTranslate()
        return true
    }
}

// MARK: - Validate
extension TranslateFormViewController {
    @IBAction func tapTranslationButton() {
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, validateButton: translationButton)
        choiceLanguageToTranslate()
    }
    
    // BONUS
    @IBAction func selectLanguage(_ sender: Any) {
        switch choiceLanguageSegmentedControl.selectedSegmentIndex {
        case 0:
            refreshText(translateBase: frenchWelcome,
                        translationBase: englishWelcome,
                        textToTranslate: frenchLanguage,
                        translation: englishLanguage)
        case 1:
            refreshText(translateBase: englishWelcome,
                        translationBase: frenchWelcome,
                        textToTranslate: englishLanguage,
                        translation: frenchLanguage)
        default:
            presentAlert(message: "An error occurred")
        }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        customInterface(label: translationLabel, textField: translateTextField, button: translationButton)
        refreshText(translateBase: frenchWelcome,
                    translationBase: englishWelcome,
                    textToTranslate: frenchLanguage,
                    translation: englishLanguage)
    }
    
    // MARK: - Methods
    // To translate french in english or english in french (BONUS)
    func getTranslation(target: String, source: String) {
        guard let textToTranslate = translateTextField?.text else { return }
        
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, validateButton: translationButton)
        
        translationService.getTranslation(textToTranslate: textToTranslate,
                                        target: target,
                                        source: source) { (success, translation) in
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
    
    // get the languages
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
    
    // BONUS
    // choice the translation in english or in french
    private func choiceLanguageToTranslate() {
        switch choiceLanguageSegmentedControl.selectedSegmentIndex {
        case 0:
            getTranslation(target: englishLanguage, source: frenchLanguage)
        case 1:
            getTranslation(target: frenchLanguage, source: englishLanguage)
        default:
            presentAlert(message: "An error occurred.")
        }
    }

    // Display welcome basic text and get the languages selected
    private func refreshText(translateBase: String,
                             translationBase: String,
                             textToTranslate: String,
                             translation: String) {
        translateTextField.text = String()
        translateTextField.placeholder = translateBase
        translationLabel.text = " " + translationBase
        getLanguages(textToTranslate: textToTranslate, translation: translation)
    }
}
