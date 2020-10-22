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
    
    private let translationService = TranslationService()
    private let frenchWelcome = LanguageChosen.french.welcome()
    private let frenchLanguage = LanguageChosen.french.language()
    private let englishWelcome = LanguageChosen.english.welcome()
    private let englishLanguage = LanguageChosen.english.language()
    private let germanLanguage = LanguageChosen.german.language()
    private let germanWelcome = LanguageChosen.german.welcome()
    private let frenchToDisplay = LanguageChosen.french.languageSelected()
    private let englishToDisplay = LanguageChosen.english.languageSelected()
    private let germanToDisplay = LanguageChosen.german.languageSelected()
    
    private var languages: Languages?
    
    // MARK: - Outlets
    
    @IBOutlet weak var translationButton: UIButton!
    @IBOutlet weak var textToTranslateLabel: UILabel!
    @IBOutlet weak var languageTranslationLabel: UILabel!
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var translateTextField: UITextField!
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
    
    // BONUS : allowing the user to choose a translation language
    @IBAction func selectLanguage(_ sender: UISegmentedControl) {
        switch choiceLanguageSegmentedControl.selectedSegmentIndex {
        case 0:
            let translationParametersFrToEn = TranslationParemeters(translateBase: frenchWelcome,
                                                              translationBase: englishWelcome,
                                                              textToTranslate: frenchLanguage,
                                                              translation: englishLanguage,
                                                              textToTranslateToDisplay: frenchToDisplay,
                                                              translationToDisplay: englishToDisplay)
            refreshText(translationParametersFrToEn)
        case 1:
            let translationParametersEnToFr = TranslationParemeters(translateBase: englishWelcome,
                                                              translationBase: frenchWelcome,
                                                              textToTranslate: englishLanguage,
                                                              translation: frenchLanguage,
                                                              textToTranslateToDisplay: englishToDisplay,
                                                              translationToDisplay: frenchToDisplay)
            refreshText(translationParametersEnToFr)
        case 2:
            let translationParametersFrToGe = TranslationParemeters(translateBase: frenchWelcome,
                                                              translationBase: germanWelcome,
                                                              textToTranslate: frenchLanguage,
                                                              translation: germanLanguage,
                                                              textToTranslateToDisplay: frenchToDisplay,
                                                              translationToDisplay: germanToDisplay)
            refreshText(translationParametersFrToGe)
        default:
            let translationParametersGeToFr = TranslationParemeters(translateBase: germanWelcome,
                                                              translationBase: frenchWelcome,
                                                              textToTranslate: germanLanguage,
                                                              translation: frenchLanguage,
                                                              textToTranslateToDisplay: germanToDisplay,
                                                              translationToDisplay: frenchToDisplay)
            refreshText(translationParametersGeToFr)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customInterfaceTranslation(textView: translationTextView,
                                   textField: translateTextField,
                                   button: translationButton)
        let translationParametersFrench = TranslationParemeters(translateBase: frenchWelcome,
                                                          translationBase: englishWelcome,
                                                          textToTranslate: frenchLanguage,
                                                          translation: englishLanguage,
                                                          textToTranslateToDisplay: frenchToDisplay,
                                                          translationToDisplay: englishToDisplay)
        refreshText(translationParametersFrench)
    }
    
    // MARK: - Methods
    
    /// to translate french in english or english in french (BONUS)
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
                self.translationTextView.text = translation.data.translations[0].translatedText
            } else {
                self.presentAlert(message: "The translation download failed.")
            }
        }
    }
    
    /// get the languages
    func getLanguages(textToTranslate: String, translation: String) {
        translationService.getLanguage { (success, languages) in
            if success, let languages = languages {
                self.languages = languages
            } else {
                self.presentAlert(message: "The language download failed.")
            }
        }
    }
    
    /// choice the translation in english or in french (BONUS)
    private func choiceLanguageToTranslate() {
        switch choiceLanguageSegmentedControl.selectedSegmentIndex {
        case 0:
            getTranslation(target: englishLanguage, source: frenchLanguage)
        case 1:
            getTranslation(target: frenchLanguage, source: englishLanguage)
        case 2:
            getTranslation(target: germanLanguage, source: frenchLanguage)
        default:
            getTranslation(target: frenchLanguage, source: germanLanguage)
        }
    }

    /// display welcome basic text and get the languages selected
    private func refreshText(_ translationsParameters: TranslationParemeters) {
        translateTextField.text = String()
        translateTextField.placeholder = translationsParameters.translateBase
        translationTextView.text = translationsParameters.translationBase
        textToTranslateLabel.text = translationsParameters.textToTranslateToDisplay
        languageTranslationLabel.text = translationsParameters.translationToDisplay
        getLanguages(textToTranslate: translationsParameters.textToTranslate,
                     translation: translationsParameters.translation)
    }
}
