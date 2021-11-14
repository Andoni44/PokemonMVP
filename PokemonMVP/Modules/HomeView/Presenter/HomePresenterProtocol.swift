//
//  HomePresenter.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    
    var view: HomeViewProtocol? { get set }
    var remoteDataSource: ApiFactoryProtocol { get set }
    
    func didLoad()
    func next()
    func showPokemonDetail(fromUrl url: String,
                           andUpdateList list: Results)
    func saveList(_ list: Results)
}
