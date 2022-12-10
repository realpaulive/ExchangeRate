//
//  CurrencyTableViewCell.swift
//  ExchangeRate
//
//  Created by Paul Ive on 10.12.22.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
  
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyKey: UILabel!
    @IBOutlet weak var currancyName: UILabel!
    @IBOutlet weak var currancyValue: UILabel!
    @IBOutlet weak var dailyChange: UILabel!
    
}
