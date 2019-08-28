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
    
    // MARK: - Outlets
    @IBOutlet weak var translationButton: UIButton!
    @IBOutlet weak var frenchLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

// MARK: - Keyboard
extension TranslateFormViewController: UITextFieldDelegate {
//    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
//        amountTextField.resignFirstResponder()
//    }
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        amountTextField.resignFirstResponder()
    //        return true
    //    }
}

// MARK: - Validate
extension TranslateFormViewController {
    @IBAction func tapTranslationButton() {
        toggleActivityIndicator(shown: true)
//        symbolSelected()
//        getRate()
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        customInterface()
//        currencyPickerViewer.isHidden = true
//        getCurrency()
    }
    
    // MARK: - Methods
//    private func getCurrency() {
//        currencyService.getCurrency { (success, symbols) in
//            self.toggleActivityIndicator(shown: false)
//            if success, let symbols = symbols {
//                self.orderSymbolsByAlpha(symbols: symbols)
//            } else {
//                // display an error message
//                self.presentAlert(message: "The symbol of currency download failed.")
//            }
//            self.currencyPickerViewer.isHidden = false
//        }
//    }
    
//    private func symbolSelected() {
//        let currencyIndex = currencyPickerViewer.selectedRow(inComponent: 0)
//        let currency = symbols[currencyIndex]
//        self.symbolPicked = currency
//    }
    
    // Reorganize the list in alphabetical order
//    private func orderSymbolsByAlpha(symbols: [String]) {
//        let symbolA = symbols.filter({ Array($0)[0] == "A" })
//        let symbolU = symbols.filter({ Array($0)[0] == "U" })
//        let symbolE = symbols.filter({ Array($0)[0] == "E" })
//        let symbolByAlpha = symbolA + symbolE + symbolU
//        self.symbols = symbolByAlpha.sorted()
//    }
    
//    private func getRate() {
//        currencyService.getRate(symbol: symbolPicked) { (success, rate) in
//            self.toggleActivityIndicator(shown: false)
//            if success, let rate = rate {
//                guard let amount = self.amountTextField?.text else { return }
//                guard let doubleAmount = Double(amount) else { return }
//                let convertedAmount = rate * doubleAmount
//                self.convertedAmountLabel.text = String(convertedAmount)
//            } else {
//                // display an error message
//                self.presentAlert(message: "The exchange rate download failed.")
//            }
//        }
//    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        translationButton.isHidden = shown
    }
    
    // Custom inteface
    private func customInterface() {
        customTranslationLabel()
        customTranslateTextField()
        customTranslationButton()
    }
    
    // Custom label translation
    private func customTranslationLabel() {
        translationLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        translationLabel.layer.cornerRadius = 10
        translationLabel.layer.shadowColor = UIColor.black.cgColor
        translationLabel.layer.shadowOpacity = 0.8
    }
    
    // Custom textField translate
    private func customTranslateTextField() {
        translateTextField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        translateTextField.layer.cornerRadius = 10
        translateTextField.layer.shadowColor = UIColor.black.cgColor
        translateTextField.layer.shadowOpacity = 0.8
    }
    
    // Custom button translation
    private func customTranslationButton() {
        translationButton.layer.cornerRadius = 10
        translationButton.layer.shadowColor = UIColor.black.cgColor
        translationButton.layer.shadowOpacity = 0.8
    }
    
    // Alert message to user
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
