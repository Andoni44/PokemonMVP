//
//  ApiFactory.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

struct ApiFactory: ApiFactoryProtocol {
    
    let endPoint = "https://pokeapi.co/api/v2/pokemon"
    var session: URLSessionProtocol
    var dataTask: URLSessionDataTask?
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
}
