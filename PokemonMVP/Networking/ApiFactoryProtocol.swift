//
//  ApiFactoryProtocol.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

protocol ApiFactoryProtocol {
    
    var endPoint: String { get }
    var session: URLSessionProtocol { get set }

    func getData<T: Decodable>(fromEndPoint endPoint: String, completion: @escaping ((Result<T, NetworkError>) -> Void))
}
