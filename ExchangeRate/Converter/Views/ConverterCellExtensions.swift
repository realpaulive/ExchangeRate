//
//  ConverterCellExtensions.swift
//  ExchangeRate
//
//  Created by Paul Ive on 02.03.23.
//

import Foundation
import UIKit

extension ConverterCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            self.valuteValue.text = "0"
            self.valuteValue.placeholder = "0"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let key = self.valuteKey.text
        var text = textField.text ?? ""
        
        if string == "" {
            text.removeLast()
        } else {
            text += string
        }
        guard text != "" else {
            self.valuteValue.text = "0"
            text = "0"
            return true
        }
        guard let value = self.valuteValueStatic else { return true }
        guard let valuteNominal = self.valuteNominal else { return true }
        
        let textString =  String((Double(text) ?? 0) * value / valuteNominal)
        
        let userInfo = [key : textString]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "textDidChange"), object: nil, userInfo: userInfo as [AnyHashable : Any])
        
        return true
    }
}

extension ConverterCell {
    func returnRightValue (valute: Valutes, valueString value: String?) -> String {
        let valueDouble = Double(value ?? "0")!
        let currencyValueDouble = Double(valute.currencyValueString) ?? 1
        let valuteNominal = Double(valute.nominalString) ?? 1
        let result = valueDouble / currencyValueDouble * valuteNominal
        var resultStrig: String {
            return String(format: "%.2f", result)
        }
        
        return resultStrig
    }
}
