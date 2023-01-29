//
//  ConverterCell.swift
//  ExchangeRate
//
//  Created by Paul Ive on 30.01.23.
//

import UIKit

class ConverterCell: UITableViewCell {
    
    

    @IBOutlet weak var valuteImage: UIImageView!
    @IBOutlet weak var valuteKey: UILabel!
    @IBOutlet weak var valuteName: UILabel!
    @IBOutlet weak var valuteValue: UITextField!
    
    
    func setUpCell (valutes: Valutes, key: String) {
        self.valuteKey.text = key
        self.valuteName.text = valutes.name
        self.valuteImage.image = UIImage(named: key)
        self.valuteImage.layer.cornerRadius = self.valuteImage.frame.size.height / 4
        self.valuteImage.layer.borderWidth = 0.2
        self.valuteImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
        
        self.valuteValue.text = valutes.currencyValueString
        
    }
    
    
}
