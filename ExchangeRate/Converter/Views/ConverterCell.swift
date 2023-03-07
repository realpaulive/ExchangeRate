//
//  ConverterCell.swift
//  ExchangeRate
//
//  Created by Paul Ive on 30.01.23.
//
import UIKit

final class ConverterCell: UITableViewCell {
    
    // MARK: - Values
    
    let reusableCellIdentifier = "ConverterCell"
    var valuteValueStatic: Double?
    var valuteNominal: Double?
    var changedValue: String?
    
    // MARK: - Outlets
    
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var valuteImage: UIImageView!
    @IBOutlet weak var valuteKey: UILabel!
    @IBOutlet weak var valuteName: UILabel!
    @IBOutlet weak var valuteValue: UITextField! {
        didSet {
            valuteValue.delegate = self
        }
    }
    
    // MARK: - Methods
    
    func setUpCell (valutes: Valutes, key: String, textFieldChange: String?) {
        
        self.valuteValueStatic = Double(valutes.currencyValueString)
        self.valuteNominal = Double(valutes.nominalString)
        
        let changedValue = returnRightValue(valute: valutes, valueString: textFieldChange)
        self.changedValue = changedValue
        
        symbol.text = Constants.sybmols[key] ?? ""
        valuteKey.text = key
        valuteName.text = valutes.name
        valuteImage.image = UIImage(named: key)
        valuteImage.layer.cornerRadius = self.valuteImage.frame.size.height / 4
        valuteImage.layer.borderWidth = 0.2
        valuteImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
        
        valuteValue.text = changedValue
        valuteValue.placeholder = changedValue
        valuteValue.keyboardType = .decimalPad
        valuteValue.clearsOnBeginEditing = true
        valuteValue.addDoneButtonToKeyboard()
    }
    
    // MARK: - FirstResponder
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        valuteValue.becomeFirstResponder()
    }
}
