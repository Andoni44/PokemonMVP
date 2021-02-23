//
//  DetailViewRouterProtocol.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import Foundation

protocol DetailRouterProtocol: RouterProtocol {
    
    func pop(fromView view: DetailViewProtocol)
}
