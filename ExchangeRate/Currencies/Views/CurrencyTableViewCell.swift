//
//  CurrencyTableViewCell.swift
//  ExchangeRate
//
//  Created by Paul Ive on 10.12.22.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyKey: UILabel!
    @IBOutlet weak var currancyName: UILabel!
    @IBOutlet weak var currancyValue: UILabel!
    @IBOutlet weak var dailyChange: UILabel!
    
    // MARK: - Methods
    
    func setUpCell (valutes: Valutes, key: String) {
        self.currencyKey?.text = key
        self.currancyName?.text = { return valutes.nominalString + " " + valutes.name }()
        self.currancyValue.text =  { return valutes.currencyValueString + " ₽" }()
        self.dailyChange.text = valutes.dailyChangePercentString
        self.dailyChange.textColor = UIColor(named: valutes.dailyChangeColor)
        
        self.currencyImage.image = UIImage(named: key)
        self.currencyImage.layer.cornerRadius = self.currencyImage.frame.size.height / 4
    }
    
}
