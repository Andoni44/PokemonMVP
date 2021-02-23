//
//  DetailRouter.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import UIKit

final class DetailRouter {
    
}

// MARK: - Router implementation
extension DetailRouter: DetailRouterProtocol {
    
    func createViewController() -> UIViewController {
        let view: DetailViewProtocol = DetailView()
        let presenter: DetailPresenterProtocol = DetailPresenter()
        presenter.router = self
        presenter.view = view
        view.presenter = presenter
        
        if let view = view as? UIViewController {
            return view
        } else { return UIViewController()}
    }
    
    func pop(fromView view: DetailViewProtocol) {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }
}
