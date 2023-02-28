//
//  Constants.swift
//  ExchangeRate
//
//  Created by Paul Ive on 10.12.22.
//

import Foundation

//MARK: - Constants

struct Constants {
    private init() {}
    
    static let currencyKeys = ["AUD", "AZN", "GBP", "AMD", "BYN", "BGN", "BRL", "HUF", "VND", "HKD", "GEL", "DKK", "AED", "USD", "EUR", "EGP", "INR", "IDR", "KZT", "CAD", "QAR", "KGS", "CNY", "MDL", "NZD", "NOK", "PLN", "RON", "SGD", "TJS", "THB", "TRY", "TMT", "UZS", "UAH", "CZK", "SEK", "CHF", "RSD", "ZAR", "KRW", "JPY"]
    
    static var favoritesKeys = ["USD", "EUR", "TRY", "GEL"] {
        didSet {
            Constants.save(favoritesKeys)
        }
    }
    
    static var converterKeys = ["USD", "EUR"]
    
    static var ruble = Valutes(currentRateData: Valute(id: "001", numCode: "001", charCode: "None", nominal: 1, name: "Российский рубль", value: 1, previous: 1))
}

//MARK: - Saving favorite currencies

extension Constants {
    
    static let userDefaultsKey = "favoritesKeys"
    
    static func save(_ favorites: [String]) {
        UserDefaults.standard.set(favorites, forKey: Constants.userDefaultsKey)
    }
    
    static func loadFavorites() {
        Constants.favoritesKeys = UserDefaults.standard.stringArray(forKey: Constants.userDefaultsKey) ?? []
    }
    
}
