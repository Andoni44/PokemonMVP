//
//  HomeRouter.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import UIKit

struct HomeRouter {
    
}

// MARK: - HomeRouter implementation

extension HomeRouter: HomeRouterProtocol {

    func createViewController() -> UIViewController {
        let presenter: HomePresenterProtocol = HomePresenter(router: self)
        let homeView: HomeViewProtocol = HomeView(presenter: presenter)
        presenter.view = homeView
        let homeDataSource: HomeDataSourceProtocol = HomeDataSource()
        homeView.dataSource = homeDataSource
        if let view = homeView as? UIViewController {
            return UINavigationController(rootViewController: view)
        } else {
            return UIViewController()
        }
    }
    
    func pushDetailView(fromView view: HomeViewProtocol,
                        presentData data: Pokemon,
                        deleteAction: @escaping () -> ()) {
        DispatchQueue.main.async {
            let detailView = DetailRouter().viewController
            if let dV = detailView as? DetailViewProtocol {
                dV.pokemon = data
                dV.deleteAction = deleteAction
            }
            if let view = view as? UIViewController {
                view.navigationController?.pushViewController(detailView, animated: true)
            }
        }
    }
}
