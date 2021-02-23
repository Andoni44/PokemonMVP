//
//  DetailViewPresenterProtocol.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import Foundation

protocol DetailPresenterProtocol: class {
    
    var view: DetailViewProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    
    func didLoad()
    func returnTypes(pokemon: Pokemon) -> [TypeName]
    func returnAbilitiesNames(pokemon: Pokemon) -> [String]
    func removePokemon(name: String)
}
