//
//  ConverterHeaderView.swift
//  ExchangeRate
//
//  Created by Paul Ive on 28.02.23.
//

import UIKit

final class ConverterHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var valuteKeyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valuteValue: UITextField!
    
    func setUpHeader (valutes: Valutes, key: String, textFieldChange: String?) {
        valuteKeyLabel.text = key
        nameLabel.text = valutes.name
        imageView.image = UIImage(named: key)
        imageView.layer.cornerRadius = self.imageView.frame.size.height / 4
        imageView.layer.borderWidth = 0.2
        imageView.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
        
        var resultOfConverting = {
            return 0
        }
        
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



