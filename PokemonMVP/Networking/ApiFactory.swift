//
//  ApiFactory.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

final class ApiFactory: ApiFactoryProtocol {
    
    let endPoint = "https://pokeapi.co/api/v2/pokemon"
    let session: URLSessionProtocol
    var dataTask: URLSessionDataTask?
    init(session: URLSessionProtocol?) {
        guard let session = session else {
            self.session = URLSession.shared
            return
        }
        self.session = session
    }
}
