//
//  FetchRequest.swift
//  ExchangeRate
//
//  Created by Paul Ive on 24.12.22.
//

import Foundation
import Alamofire

// MARK: - AFRequest

class FetchRequest {
    static func currencyRequest (completion: @escaping ([String : Valutes]) -> ()) {
        let urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
        guard let url = URL(string: urlString) else { return }
        AF.request(url, method: .get).validate().responseDecodable(of: Response.self, queue: .global(qos: .utility)) { response in
            switch response.result {
            case .success(let value):
                let keys = Constants.currencyKeys
                var valutes = [String : Valutes]()
                for key in keys {
                    valutes[key] = Valutes(currentRateData: value.valute[key]!)
                }
                completion(valutes)
            case .failure(let error):
                print(error)
            }
        }
    }
}
