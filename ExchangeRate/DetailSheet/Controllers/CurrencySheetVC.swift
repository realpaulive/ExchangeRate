//
//  CurrancySheetVC.swift
//  ExchangeRate
//
//  Created by Paul Ive on 11.12.22.
//

import UIKit

final class CurrencySheetViewController: UIViewController {
  
    
    // MARK: - Values
    
    var key: String = "USD"
    var isFromFavorites = false
    var valutes = [String : Valutes]()
    var lastUpdateString: String?
    var favoritesContainsValute = false
    var converterContainsValute = false

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
        
        
        FetchRequest.shared.currencyRequest { [unowned self] valutes, timestamp in
            self.valutes = valutes
            self.lastUpdateString = timestamp
            
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
        if Constants.converterKeys.contains(self.key) {
            addToConverter.setTitle("Удалить из конвертера", for: .normal)
            addToConverter.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
            converterContainsValute.toggle()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        addToFavoriteButtonPressed(favoritesContainsValute: favoritesContainsValute)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    @IBAction func addToConverter(_ sender: UIButton) {
        addToConverterButtonPressed(converterContainsValute: converterContainsValute)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
}

// MARK: - Extension: PresentationDelegates

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
        self.lastUpdate.text = lastUpdateString
        self.currencyDescription.text = Constants.texts[key]
    }
    
    func addToFavoriteButtonPressed(favoritesContainsValute: Bool) {
        if !favoritesContainsValute {
            Constants.favoritesKeys.append(self.key)
            self.favoritesContainsValute.toggle()
            
            addToFavorite.setTitle("Удалить из избранного", for: .normal)
            addToFavorite.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFavorites"), object: nil)
        } else {
            guard let index = Constants.favoritesKeys.firstIndex(of: self.key) else { return }
            
            Constants.favoritesKeys.remove(at: index)
            self.favoritesContainsValute.toggle()
            
            addToFavorite.setTitle("Добавить в избранное", for: .normal)
            addToFavorite.setImage(UIImage(systemName: "flame.fill"), for: .normal)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFavorites"), object: nil)
            
            if isFromFavorites {
                print("deleted")
                self.dismiss(animated: true)
            }
        }
    }
    
    func addToConverterButtonPressed(converterContainsValute: Bool) {
        if !converterContainsValute {
            Constants.converterKeys.append(self.key)
            self.converterContainsValute.toggle()
            
            addToConverter.setTitle("Удалить из конвертрев", for: .normal)
            addToConverter.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadConverter"), object: nil)
        } else {
            guard let index = Constants.converterKeys.firstIndex(of: self.key) else { return }
            
            Constants.converterKeys.remove(at: index)
            self.converterContainsValute.toggle()
            
            addToConverter.setTitle("Добавить в конвертер", for: .normal)
            addToConverter.setImage(UIImage(systemName: "plusminus.circle.fill"), for: .normal)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadConverter"), object: nil)
            
        }
    }
}
