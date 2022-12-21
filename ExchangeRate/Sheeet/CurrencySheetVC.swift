//
//  CurrancySheetVC.swift
//  ExchangeRate
//
//  Created by Paul Ive on 11.12.22.
//

import UIKit

class CurrencySheetViewController: UIViewController {
    
    
    let constants = Constants()
    let updatedCurrensies = UpdateCurrencies.shared
    var key: String = "USD"
    
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var dailyChangePercent: UILabel!
    @IBOutlet weak var dailyChangeValue: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var addToFavorite: UIButton!
    @IBOutlet weak var currencyDescription: UILabel!
    @IBOutlet weak var addToConverter: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetPresentationController!.delegate = self
        
        self.updatedCurrensies.saveCurrencies()
        let timestamp = updatedCurrensies.data?.timestamp
        let valute = updatedCurrensies.valutes[key]
        
        currencyName.text = { return valute!.nominalString + " " + valute!.name }()
        currencyImage.image = UIImage(named: key) ?? UIImage(systemName: "Person")
        currencyImage.layer.cornerRadius = currencyImage.frame.size.height / 4
        currencyImage.layer.borderWidth = 0.2
        currencyImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
        currencyValue.text = { return valute!.currencyValueString + " ₽" }()
        dailyChangePercent.text = valute?.dailyChangePercentString
        dailyChangePercent.textColor = UIColor(named: valute!.dailyChangeColor)
        dailyChangeValue.text = valute?.dailyChangeValueString
        dailyChangeValue.textColor = UIColor(named: valute!.dailyChangeColor)
        lastUpdate.text = timestamp!
        
    }
    
}

extension CurrencySheetViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
}
