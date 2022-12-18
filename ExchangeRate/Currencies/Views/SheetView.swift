//
//  SheetView.swift
//  ExchangeRate
//
//  Created by Paul Ive on 18.12.22.
//
//
//import UIKit
//
//class SheetView: UIView {
//
//    @IBOutlet weak var currencyName: UILabel!
//    @IBOutlet weak var currencyImage: UIImageView!
//    @IBOutlet weak var currencyValue: UILabel!
//    @IBOutlet weak var dailyChangePercent: UILabel!
//    @IBOutlet weak var dailyChangeValue: UILabel!
//    @IBOutlet weak var lastUpdate: UILabel!
//    @IBOutlet weak var addToFavorite: UIButton!
//    @IBOutlet weak var currencyDescription: UILabel!
//    @IBOutlet weak var addToConverter: UIButton!
//
//    func configureSheetView (valute: Valutes, key: String) {
//        currencyName.text = key
//        currencyImage.image = UIImage(named: key) ?? UIImage(systemName: "Person")
//        currencyImage.layer.cornerRadius = currencyImage.frame.size.height / 4
//        currencyImage.layer.borderWidth = 0.2
//        currencyImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
//        currencyValue.text = { return valute.currencyValueString + " ₽" }()
//        dailyChangePercent.text = valute.dailyChangeString
//        dailyChangeValue.text = valute.dailyChangeString
////        lastUpdate.text = response?.timestamp
//    }
//
//}
