//
//  HomePresenterMocking.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 21/2/21.
//

import Foundation

protocol URLSessionProtocol {
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    
}
