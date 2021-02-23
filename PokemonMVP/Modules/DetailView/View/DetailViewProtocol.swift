//
//  DetailViewProtocol.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import Foundation

protocol DetailViewProtocol: class {
    
    var deleteAction: (() -> ())? { get set }
    var presenter: DetailPresenterProtocol? { get set }
    var pokemon: Pokemon? { get set }
}
