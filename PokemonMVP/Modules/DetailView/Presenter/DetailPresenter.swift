//
//  DetailViewPresenter.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import Foundation

final class DetailPresenter {
    
    ///Components
    weak var view: DetailViewProtocol?
    var router: DetailRouterProtocol?
    var coreDatamanager: CoreDataManagerProtocol = CoreDataManager()
}

// MARK: - Presenter
extension DetailPresenter: DetailPresenterProtocol {
    
    func returnTypes(pokemon: Pokemon) -> [TypeName] {
        let types: [TypeName]  = pokemon.types.map { $0.type.name }
        return types
    }
    
    func returnAbilitiesNames(pokemon: Pokemon) -> [String] {
        let abilities: [String]  = pokemon.abilities.map { $0.ability.name }
        return abilities
    }
    
    /*
     * Update view
     */
    func didLoad() {
        
    }
    
    /*
     * Remove Pokemon
     */
    func removePokemon(name: String) {
        guard let view = view, let deleteAction = view.deleteAction else { return }
        coreDatamanager.removeData(byName: name)
        deleteAction()
        router?.pop(fromView: view)
    }
}
