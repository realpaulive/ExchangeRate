//
//  CurrancySheetVC.swift
//  ExchangeRate
//
//  Created by Paul Ive on 11.12.22.
//

import UIKit

class CurrencySheetViewController: UIViewController {
  
    
    // MARK: - Values
    
    var key: String = "USD"
    var isLastVCwasFavoriteVC = false
    var valutes = [String : Valutes]()
    var favoritesContainsValute = false
    
    // MARK: - Outlets
    
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var dailyChangePercent: UILabel!
    @IBOutlet weak var dailyChangeValue: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var addToFavorite: UIButton!
    @IBOutlet weak var currencyDescription: UILabel!
    @IBOutlet weak var addToConverter: UIButton!
    
    
    //MARK: - ViewFunctions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetPresentationController!.delegate = self
        
        
        FetchRequest.currencyRequest { valutes in
            self.valutes = valutes
            
            DispatchQueue.main.async {
                guard let valute = valutes[self.key] else {
                    print("error")
                    return
                }
                self.configureSheetView(valute: valute, key: self.key)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Constants.favoritesKeys.contains(self.key) {
            addToFavorite.setTitle("Удалить из избранного", for: .normal)
            addToFavorite.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
            favoritesContainsValute.toggle()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        addToFavoriteButtonPressed(favoritesContainsValute: favoritesContainsValute)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
}

// MARK: - Extension: Delegates

extension CurrencySheetViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
}


// MARK: - Extension: BusinessLogic

extension CurrencySheetViewController {
    func configureSheetView (valute: Valutes, key: String) {
        self.currencyName.text = { return valute.nominalString + " " + valute.name }()
        self.currencyImage.image = UIImage(named: key) ?? UIImage(systemName: "Person")
        self.currencyImage.layer.cornerRadius = self.currencyImage.frame.size.height / 4
        self.currencyImage.layer.borderWidth = 0.2
        self.currencyImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
        self.currencyValue.text = { return valute.currencyValueString + " ₽" }()
        self.dailyChangePercent.text = valute.dailyChangePercentString
        self.dailyChangePercent.textColor = UIColor(named: valute.dailyChangeColor)
        self.dailyChangeValue.text = valute.dailyChangeValueString
        self.dailyChangeValue.textColor = UIColor(named: valute.dailyChangeColor)
        self.lastUpdate.text = "Дата и время"
    }
    
    func addToFavoriteButtonPressed(favoritesContainsValute: Bool) {
        if !favoritesContainsValute {
            Constants.favoritesKeys.append(self.key)
            self.favoritesContainsValute.toggle()
            
            addToFavorite.setTitle("Удалить из избранного", for: .normal)
            addToFavorite.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        } else {
            guard let index = Constants.favoritesKeys.firstIndex(of: self.key) else { return }
            
            Constants.favoritesKeys.remove(at: index)
            self.favoritesContainsValute.toggle()
            
            addToFavorite.setTitle("Добавить в избранное", for: .normal)
            addToFavorite.setImage(UIImage(systemName: "flame.fill"), for: .normal)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            if isLastVCwasFavoriteVC {
                print("deleted")
                self.dismiss(animated: true)
            }
        }
    }
}
