//
//  FetchRequest.swift
//  ExchangeRate
//
//  Created by Paul Ive on 24.12.22.
//

import Foundation
import Alamofire

// MARK: - AFRequest (SingleTone)

final class FetchRequest {
    
    static let shared = FetchRequest()
  
    func currencyRequest (completion: @escaping ([String : Valutes], String) -> ()) {
        let urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
        guard let url = URL(string: urlString) else { return }
        AF.request(url, method: .get).validate().responseDecodable(of: Response.self, queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let value):
                let keys = Constants.currencyKeys
                var valutes = [String : Valutes]()
                for key in keys {
                    valutes[key] = Valutes(currentRateData: value.valute[key]!)
                }
                let timestamp = TimeStamp().lastUpdate(timeString: value.timestamp)  
                completion(valutes, timestamp)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private init() { }
}
