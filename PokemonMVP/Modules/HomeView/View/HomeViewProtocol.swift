//
//  HomeViewProtocol.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    var dataSource: HomeDataSourceProtocol? { get set }
    
    func updateList(withData data: Results)
    func updateList(replacingData data: Results)
    func startAnimating()
    func stopAnimating()
    func getPokemonData() -> Results
}
