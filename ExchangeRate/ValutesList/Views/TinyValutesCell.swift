//
//  tinyValutesCell.swift
//  ExchangeRate
//
//  Created by Paul Ive on 29.01.23.
//

import UIKit

class TinyValutesCell: UITableViewCell {
    
    // MARK: - Identifier
    
    let reusableCellIdentifier = "TinyValutesCell"
    
    // MARK: - Outlets

    @IBOutlet weak var valuteImage: UIImageView!
    @IBOutlet weak var valuteKey: UILabel!
    @IBOutlet weak var valuteName: UILabel!
    @IBOutlet weak var isAtSomeList: UIImageView!
    
    // MARK: - Methods
    
    func setUpCell (valutes: Valutes, key: String) {
        self.valuteKey?.text = key
        self.valuteName?.text = { return valutes.nominalString + " " + valutes.name }()
     
        self.valuteImage.image = UIImage(named: key)
        self.valuteImage.layer.cornerRadius = self.valuteImage.frame.size.height / 4
        self.valuteImage.layer.borderWidth = 0.2
        self.valuteImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
    }
}
