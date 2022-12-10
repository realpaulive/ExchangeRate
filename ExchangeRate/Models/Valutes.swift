//
//  Valutes.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//


import Foundation

struct Valutes {
    var name: String
    var nominal: Int
    var nominalString: String {
        return String(nominal)
    }
    var currencyValue: Double
    var currencyValueString: String {
        return String(format: "%.2f", currencyValue)
    }
    var previousValue: Double
    var dailyChange: Double {
        return (currencyValue/previousValue - 1) * 100
    }
    var dailyChangeColor: String {
        if dailyChange > 0 {
            return "Green" }
        else if
            dailyChange < 0 { return "Red" } else { return "Default" }
    }
    
    var dailyChangeString: String {
        if dailyChange > 0 {
            return "+" + String(format: "%.2f", dailyChange) + "%" }
        else if
            dailyChange < 0 { return String(format: "%.2f", dailyChange) + "%" } else { return "0 %" }
    }
    
    
    
    
    init? (currentRateData: Valute) {
        name = currentRateData.name
        currencyValue = currentRateData.value
        previousValue = currentRateData.previous
        nominal = currentRateData.nominal
    }
}

