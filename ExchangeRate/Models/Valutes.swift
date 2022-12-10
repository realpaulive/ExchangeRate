//
//  Valutes.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//


import Foundation

struct Valutes {
    var name: String
    var currencyValue: Double
    var currencyValueString: String {
        return String(format: "%.2f", currencyValue)
    }
    var previousValue: Double
    var dailyChange: Double {
        return (currencyValue/previousValue - 1) * 100
    }
    var dailyChangeString: String {
        return String(format: "%.2f", dailyChange)
    }
    
    init? (currentRateData: Valute) {
        name = currentRateData.name
        currencyValue = currentRateData.value
        previousValue = currentRateData.previous
    }
}

