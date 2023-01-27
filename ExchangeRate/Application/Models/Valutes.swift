//
//  Valutes.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//


import Foundation

struct Valutes {
    
    // MARK: - FullName
    var name: String
    
    // MARK: - Nominal for currency
    private var nominal: Int
    var nominalString: String {
        return String(nominal)
    }
    
    // MARK: - Currency value
    private var currencyValue: Double
    var currencyValueString: String {
        return String(format: "%.2f", currencyValue)
    }
    
    // MARK: - Daily changes
    private var previousValue: Double
    
    private var dailyChangePercent: Double {
        return (currencyValue/previousValue - 1) * 100
    }
    
    var dailyChangePercentString: String {
        if dailyChangePercent > 0 {
            return "+" + String(format: "%.2f", dailyChangePercent) + "%" }
        else if
            dailyChangePercent < 0 { return String(format: "%.2f", dailyChangePercent) + "%" } else { return "0%" }
    }
    
    private var dailyChangeValue: Double {
        return currencyValue - previousValue
    }
    
    var dailyChangeValueString: String {
        if dailyChangeValue > 0 {
            return "+" + String(format: "%.2f", dailyChangeValue) + "₽" }
        else if
            dailyChangeValue < 0 { return String(format: "%.2f", dailyChangeValue) + "₽" } else { return "0₽" }
    }
    
    var dailyChangeColor: String {
        if dailyChangePercent > 0 {
            return "Green" }
        else if
            dailyChangePercent < 0 { return "Red" } else { return "Default" }
    }
    
   
    
    // MARK: - Initialisation
    init? (currentRateData: Valute) {
        name = currentRateData.name
        currencyValue = currentRateData.value
        previousValue = currentRateData.previous
        nominal = currentRateData.nominal
    }
}

