//
//  ApiFactoryProtocol.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

protocol ApiFactoryProtocol {
    
    var endPoint: String { get }
    
    func getPokemonList(fromEndPoint endPoint: String, completion: @escaping ((Result<PokemonList, NetworkError>) -> Void))
    func getPokemonDetail(fromEndPoint endPoint: String, completion: @escaping ((Result<Pokemon, NetworkError>) -> Void))
}
