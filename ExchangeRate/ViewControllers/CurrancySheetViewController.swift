//
//  CurrancySheetView.swift
//  ExchangeRate
//
//  Created by Paul Ive on 11.12.22.
//

import UIKit

class CurrancySheetViewController: UIViewController {
    
    let constants = Constants()
    var response: Response? = nil
    var indexPathRow: Int = 0
    
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var dailyChangePercent: UILabel!
    @IBOutlet weak var dailyChangeValue: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var addToFavorite: UIButton!
    @IBOutlet weak var currencyDescriotion: UILabel!
    
// MARK: - Trying to put indexPathRow value from CurrensiesViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetPresentationController!.delegate = self
//
//        let key = constants.currencyKeys[indexPathRow]
//        guard let resp = response?.valute[key] else { return }
//        let value = Valutes(currentRateData: (resp))
//
//        currencyName.text = key
//        currencyImage.image = UIImage(named: key) ?? UIImage(systemName: "Person")
//        currencyImage.layer.cornerRadius = currencyImage.frame.size.height / 4
//        currencyImage.layer.borderWidth = 0.2
//        currencyImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
//        currencyValue.text = { return value!.currencyValueString + " ₽" }()
//        dailyChangePercent.text = value?.dailyChangeString
//        dailyChangeValue.text = value?.dailyChangeString
//        lastUpdate.text = response?.timestamp
    }
//
//    init (indexPathRow: Int) {
//        self.indexPathRow = indexPathRow
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

}

extension CurrancySheetViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
}
