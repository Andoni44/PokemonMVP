//
//  HomeRouter.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import UIKit

final class HomeRouter {
    
}

// MARK: - HomeRouter implementation
extension HomeRouter: HomeRouterProtocol {
    
    /**
     * Dependency injection when a module is created
     */
    func createViewController() -> UIViewController {
        let homeView: HomeViewProtocol = HomeView()
        let presenter: HomePresenterProtocol = HomePresenter()
        presenter.router = self
        homeView.presenter = presenter
        presenter.view = homeView
        let homeDataSource: HomeDataSourceProtocol = HomeDataSource()
        homeView.dataSource = homeDataSource
        if let view = homeView as? UIViewController {
            return UINavigationController(rootViewController: view)
        } else {
            return UIViewController()
        }
    }
    
    /*
     * Present detail View
     */
    func pushDetailView(fromView view: HomeViewProtocol, presentData data: Pokemon, deleteAction: @escaping () -> ()) {
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
