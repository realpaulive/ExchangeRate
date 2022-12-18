//
//  JSONResponse.swift
//  ExchangeRate
//
//  Created by Paul Ive on 10.12.22.
//

import Foundation

// MARK: - ExchageCurrancies
struct Response: Codable {
    let timestamp: String
    let valute: [String: Valute]
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case valute = "Valute"
    }
}

// MARK: - Valute
struct Valute: Codable {
    let id, numCode, charCode: String
    let nominal: Int
    let name: String
    let value, previous: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case numCode = "NumCode"
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
        case previous = "Previous"
    }
}
