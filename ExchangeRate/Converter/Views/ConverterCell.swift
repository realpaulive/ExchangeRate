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
    @IBOutlet weak var valuteValue: UITextField!
    
    //    {
    //        let myTextField = UITextField()
    //        myTextField.clearButtonMode = .unlessEditing
    //        myTextField.clearsOnBeginEditing = false
    //        myTextField.clearsOnInsertion = true
    //        myTextField.returnKeyType = .done
    //        return myTextField
    //    }
    //
    
    // MARK: - Methods
    
    func setUpCell (valutes: Valutes, key: String) {
        valuteKey.text = key
        valuteName.text = valutes.name
        valuteImage.image = UIImage(named: key)
        valuteImage.layer.cornerRadius = self.valuteImage.frame.size.height / 4
        valuteImage.layer.borderWidth = 0.2
        valuteImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
        
        valuteValue.text = String(0)
        valuteValue.placeholder = String(0)
        valuteValue.keyboardType = .decimalPad
        valuteValue.clearsOnBeginEditing = true
        valuteValue.addDoneButtonToKeyboard()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        valuteValue.becomeFirstResponder()
    }
}
