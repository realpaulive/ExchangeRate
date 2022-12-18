//
//  UpdateCurrencies.swift
//  ExchangeRate
//
//  Created by Paul Ive on 18.12.22.
//

import Foundation
class UpdateCurrencies {
    
    private init () {}
    static let shared = UpdateCurrencies()
    
    private let networkService = NetworkService()
    private let urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
    
    var valutes = [String : Valutes]()
    var data: Response? = nil
    private let constansts = Constants()
    
    private func updateCurrencies (completion: @escaping (Response?) -> Void)  {
        networkService.fetchRequest(whithURL: urlString) { result in
            switch result {
            case .success(let response):
                completion(response)
                self.data = response
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveCurrencies () {
        updateCurrencies { response in
            let keys = self.constansts.currencyKeys
            guard let response = response else { return }
            for key in keys {
                self.valutes[key] = Valutes(currentRateData: response.valute[key]!)
            }
        }
    }
}
