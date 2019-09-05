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
    
    private var symbols = [String]()
    private var symbolPicked = String()
    private let currencyService = CurrencyService()
    
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
}

// MARK: - Validate

extension ExchangeFormViewController {
    
    @IBAction func tapConvertButton() {
        toggleActivityIndicator(shown: true,
                                activityIndicator: activityIndicator,
                                validateButton: convertButton)
        symbolSelected()
        getRate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customInterfaceExchangeRate(label: convertedAmountLabel, textField: amountTextField, button: convertButton)
        currencyPickerViewer.isHidden = true
        getCurrency()
    }
    
    // MARK: - Methods
    
    private func getCurrency() {
        currencyService.getCurrency { (success, symbols) in
            self.toggleActivityIndicator(shown: false,
                                         activityIndicator: self.activityIndicator,
                                         validateButton: self.convertButton)
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
    
    /// Reorganize the list in alphabetical order
    private func orderSymbolsByAlpha(symbols: [String]) {
        let symbolA = symbols.filter({ Array($0)[0] == "A" })
        let symbolU = symbols.filter({ Array($0)[0] == "U" })
        let symbolE = symbols.filter({ Array($0)[0] == "E" })
        let symbolByAlpha = symbolA + symbolE + symbolU
        self.symbols = symbolByAlpha.sorted()
    }
    
    private func getRate() {
        currencyService.getRate(symbol: symbolPicked) { (success, rate) in
            self.toggleActivityIndicator(shown: false,
                                         activityIndicator: self.activityIndicator,
                                         validateButton: self.convertButton)
            if success, let rate = rate {
                guard let amount = self.amountTextField?.text else { return }
                guard let doubleAmount = Double(amount) else { return }
                let convertedAmount = rate * doubleAmount
                let convertedAmountRoundToDecimal = convertedAmount.roundToDecimal(2)
                self.convertedAmountLabel.text = String(convertedAmountRoundToDecimal)
            } else {
                // display an error message
                self.presentAlert(message: "The exchange rate download failed.")
            }
        }
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
