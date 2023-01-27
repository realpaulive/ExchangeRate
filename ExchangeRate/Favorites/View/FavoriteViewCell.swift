//
//  FavoriteViewCell.swift
//  ExchangeRate
//
//  Created by Paul Ive on 18.12.22.
//

import UIKit

//Need to create collectionView

class FavoriteViewCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var dailyChangeValue: UILabel!
    @IBOutlet weak var dailyChangePercent: UILabel!
    @IBOutlet weak var currencyKey: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    
    // MARK: - Methods
    
    func setUpFavoriteCell (valutes: Valutes, key: String) {
        self.currencyKey?.text = key
        self.currencyName?.text = { return valutes.nominalString + " " + valutes.name }()
        self.currencyValue.text =  { return valutes.currencyValueString + " ₽" }()
        self.dailyChangePercent.text = valutes.dailyChangePercentString
        self.dailyChangePercent.textColor = UIColor(named: valutes.dailyChangeColor)
        self.dailyChangeValue.text = valutes.dailyChangeValueString 
        self.dailyChangeValue.textColor = UIColor(named: valutes.dailyChangeColor)
        self.currencyImage.image = UIImage(named: key)
        self.currencyImage.layer.cornerRadius = 16
        self.currencyImage.layer.borderWidth = 0.2
        self.currencyImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
    }
}
