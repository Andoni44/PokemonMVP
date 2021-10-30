//
//  ApiFactory+GetPokemonList.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

extension ApiFactory {
    
    func getData<T: Decodable>(fromEndPoint endPoint: String, completion: @escaping ((Result<T, NetworkError>) -> Void)) {
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                    completion(.failure(.noNetwork))
                    return
                }
                completion(.failure(.problem))
                return
            }
            if response.statusCode == 200 {
                    Helper.decode(data) { pokemonList in
                        completion(.success(pokemonList))
                    }
            } else {
                completion(.failure(.serverError))
            }
        }.resume()
    }
}
