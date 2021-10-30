//
//  HomeRouterProtocol.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

protocol HomeRouterProtocol: RouterProtocol {
    
    func pushDetailView(fromView view: HomeViewProtocol,
                        presentData data: Pokemon,
                        deleteAction: @escaping () -> ())
}
