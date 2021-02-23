//
//  ApiFactory+GetPokemonList.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

extension ApiFactory {
    
    func getPokemonList(fromEndPoint endPoint: String, completion: @escaping ((Result<PokemonList, NetworkError>) -> Void)) {
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                    completion(.failure(.noNetwork))
                    return
                }
                completion(.failure(.problem))
                return
            }
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let list = try decoder.decode(PokemonList.self, from: data)
                    completion(.success(list))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    completion(.failure(.problem))
                }
            } else {
                completion(.failure(.serverError))
            }
        }
        dataTask?.resume()
    }
}
