//
//  DetailRouter.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import UIKit

struct DetailRouter {
    
}

// MARK: - Router implementation
extension DetailRouter: DetailRouterProtocol {
    
    func createViewController() -> UIViewController {

        let presenter: DetailPresenterProtocol = DetailPresenter(router: self)
        let view: DetailViewProtocol = DetailView(presenter: presenter)
        presenter.view = view
        
        if let view = view as? UIViewController {
            return view
        } else { return UIViewController()}
    }
    
    func pop(fromView view: DetailViewProtocol) {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }
}
