//
//  DetailViewProtocol.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    
    var deleteAction: (() -> ())? { get set }
    var pokemon: Pokemon? { get set }
}
