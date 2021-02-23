//
//  ApiFactory+GetPokemonDetail.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import Foundation

extension ApiFactory {
    
    func getPokemonDetail(fromEndPoint endPoint: String, completion: @escaping ((Result<Pokemon, NetworkError>) -> Void)) {
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                    completion(.failure(.noNetwork))
                }
                completion(.failure(.problem))
                return
            }
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let pokemon = try decoder.decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
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
                    completion(.failure(.error))
                }
            } else {
                completion(.failure(.serverError))
            }
        }.resume()
    }

}
