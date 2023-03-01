//
//  ConverterCell.swift
//  ExchangeRate
//
//  Created by Paul Ive on 30.01.23.
//
import UIKit

final class ConverterCell: UITableViewCell {
    
    // MARK: - Identifier
    
    let reusableCellIdentifier = "ConverterCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var valuteImage: UIImageView!
    @IBOutlet weak var valuteKey: UILabel!
    @IBOutlet weak var valuteName: UILabel!
    @IBOutlet weak var valuteValue: UITextField! {
        didSet {
            valuteValue.delegate = self
        }
    }
    
    var valuteValueStatic: Double?
    
    // MARK: - Methods
    
    func setUpCell (valutes: Valutes, key: String, textFieldChange: String?) {
        
        self.valuteValueStatic = Double(valutes.currencyValueString)
        
        valuteKey.text = key
        valuteName.text = valutes.name
        valuteImage.image = UIImage(named: key)
        valuteImage.layer.cornerRadius = self.valuteImage.frame.size.height / 4
        valuteImage.layer.borderWidth = 0.2
        valuteImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
        
        valuteValue.text = textFieldChange ?? String(0)
        valuteValue.placeholder = textFieldChange ?? String(0)
        valuteValue.keyboardType = .decimalPad
        valuteValue.clearsOnBeginEditing = true
        valuteValue.addDoneButtonToKeyboard()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        valuteValue.becomeFirstResponder()
    }
}

extension ConverterCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            self.valuteValue.text = "0"
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
        guard text != "" else { return true }
        guard let value = self.valuteValueStatic else { return true }
        
        let textString =  String((Double(text) ?? 0) * value)
        
        let userInfo = [key : textString]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "textDidChange"), object: nil, userInfo: userInfo as [AnyHashable : Any])
        
        return true
    }
}
