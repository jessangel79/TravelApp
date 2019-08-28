//
//  ExchangeFormViewController.swift
//  TravelApp
//
//  Created by Angelique Babin on 05/08/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class ExchangeFormViewController: UIViewController {
    
    // MARK: - Properties
    var symbols = [String]()
    var symbolPicked = String()
    let currencyService = CurrencyService()
    
    // MARK: - Outlets
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var currencyPickerViewer: UIPickerView!
    @IBOutlet weak var convertedAmountLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: UIButton!
}

// MARK: - Keyboard
extension ExchangeFormViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        amountTextField.resignFirstResponder()
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        amountTextField.resignFirstResponder()
//        return true
//    }
}

// MARK: - Validate
extension ExchangeFormViewController {
    
    @IBAction func tapConvertButton() {
        toggleActivityIndicator(shown: true)
        symbolSelected()
        getRate()
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        customInterface()
        currencyPickerViewer.isHidden = true
        getCurrency()
    }
    
    // MARK: - Methods
    private func getCurrency() {
        currencyService.getCurrency { (success, symbols) in
            self.toggleActivityIndicator(shown: false)
            if success, let symbols = symbols {
                self.orderSymbolsByAlpha(symbols: symbols)
            } else {
                // display an error message
                self.presentAlert(message: "The symbol of currency download failed.")
            }
            self.currencyPickerViewer.isHidden = false
        }
    }
    
    private func symbolSelected() {
        let currencyIndex = currencyPickerViewer.selectedRow(inComponent: 0)
        let currency = symbols[currencyIndex]
        self.symbolPicked = currency
    }
    
    // Reorganize the list in alphabetical order
    private func orderSymbolsByAlpha(symbols: [String]) {
        let symbolA = symbols.filter({ Array($0)[0] == "A" })
        let symbolU = symbols.filter({ Array($0)[0] == "U" })
        let symbolE = symbols.filter({ Array($0)[0] == "E" })
        let symbolByAlpha = symbolA + symbolE + symbolU
        self.symbols = symbolByAlpha.sorted()
    }
    
    private func getRate() {
        currencyService.getRate(symbol: symbolPicked) { (success, rate) in
            self.toggleActivityIndicator(shown: false)
            if success, let rate = rate {
                guard let amount = self.amountTextField?.text else { return }
                guard let doubleAmount = Double(amount) else { return }
                let convertedAmount = rate * doubleAmount
                self.convertedAmountLabel.text = String(convertedAmount)
            } else {
                // display an error message
                self.presentAlert(message: "The exchange rate download failed.")
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        convertButton.isHidden = shown
    }
    
    // Custom inteface
    private func customInterface() {
        customAmountLabel()
        customAmountTextField()
        customConvertButton()
    }
    
    // Custom label convertedAmount
    private func customAmountLabel() {
        convertedAmountLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        convertedAmountLabel.layer.cornerRadius = 10
        convertedAmountLabel.layer.shadowColor = UIColor.black.cgColor
        convertedAmountLabel.layer.shadowOpacity = 0.8
    }
    
    // Custom button convert
    private func customConvertButton() {
        convertButton.layer.cornerRadius = 10
        convertButton.layer.shadowColor = UIColor.black.cgColor
        convertButton.layer.shadowOpacity = 0.8
    }
    
    // Custom textField amount
    private func customAmountTextField() {
        amountTextField.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        amountTextField.layer.cornerRadius = 10
        amountTextField.layer.shadowColor = UIColor.black.cgColor
        amountTextField.layer.shadowOpacity = 0.8
    }
    
    // Alert message to user
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - PickerView
extension ExchangeFormViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return symbols.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return symbols[row]
    }
}
