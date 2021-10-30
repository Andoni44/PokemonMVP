//
//  DetailViewPresenterProtocol.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import Foundation


// sourcery
protocol DetailPresenterProtocol: AnyObject {
    
    var view: DetailViewProtocol? { get set }
    
    func didLoad()
    func returnTypes(pokemon: Pokemon) -> [TypeName]
    func returnAbilitiesNames(pokemon: Pokemon) -> [String]
    func removePokemon(name: String)
}
