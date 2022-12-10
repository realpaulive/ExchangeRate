//
//  NetworkService.swift
//  ExchangeRate
//
//  Created by Paul Ive on 10.12.22.
//

import Foundation

class NetworkService {
    func fetchRequest (whithURL urlString: String, completion: @escaping (Result<Response, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let someParsedData = try decoder.decode(Response.self, from: data)
                    completion(.success(someParsedData))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}


