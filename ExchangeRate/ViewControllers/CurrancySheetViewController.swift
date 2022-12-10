//
//  CurrancySheetView.swift
//  ExchangeRate
//
//  Created by Paul Ive on 11.12.22.
//

import UIKit

class CurrancySheetViewController: UIViewController {

    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var dailyChangePercent: UILabel!
    @IBOutlet weak var dailyChangeValue: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var addToFavorite: UIButton!
    @IBOutlet weak var currencyDescriotion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension CurrancySheetViewController: UISheetPresentationControllerDelegate {
    
}
