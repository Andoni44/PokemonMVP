//
//  TestDoubles.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 30/10/21.
//

import UIKit

struct HomeRouterTestDouble: HomeRouterProtocol {
    func pushDetailView(fromView view: HomeViewProtocol, presentData data: Pokemon, deleteAction: @escaping () -> ()) {}
    func createViewController() -> UIViewController {
        UIViewController()
    }
}

struct DetailRouterTestDouble: DetailRouterProtocol {
    func pop(fromView view: DetailViewProtocol) {}
    func createViewController() -> UIViewController {
        UIViewController()
    }
}
