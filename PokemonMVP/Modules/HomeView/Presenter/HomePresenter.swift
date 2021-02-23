//
//  HomePresenter.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

final class HomePresenter {
    
    ///Components
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol?
    
    ///Service layer
    var session: URLSessionProtocol?
    lazy var service: ApiFactoryProtocol = ApiFactory(session: self.session)
    private var nextEndpoint: String?
    private let defaults = UserDefaults.standard
    private let coreDataManager: CoreDataManagerProtocol = CoreDataManager()
}

// MARK: - Presenter
extension HomePresenter: HomePresenterProtocol {
    
    /*
     * Upload the view
     */
    func didLoad() {
        if let next = defaults.string(forKey: App.DefaultKeys.next.rawValue) {
            nextEndpoint = next
            getSavedDate()
        } else {
            requestNewPokemons(fromEndpoint: service.endPoint)
        }
    }
    
    /*
     * Next pokemons
     */
    func next() {
        guard let next = nextEndpoint else { return }
        requestNewPokemons(fromEndpoint: next)
    }
    
    /*
     * Pokemon detail
     */
    func showPokemonDetail(fromUrl url: String, andUpdateList list: Results) {
        guard let view = view else { return }
        service.getPokemonDetail(fromEndPoint: url) { result in
            self.view?.stopAnimating()
            switch result {
            case .success(let pokemon):
                let action = {
                    let newData = list.filter{ $0.name != pokemon.name }
                    view.updateList(replacingData: newData)
                }
                self.router?.pushDetailView(fromView: view, presentData: pokemon, deleteAction: action)
            case .failure(let error):
                self.router?.presentAlert(onView: view, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }
    
    func saveList(_ list: Results) {
        DispatchQueue.main.async {
            self.coreDataManager.saveData(results: list)
        }
    }
}

// MARK: - Inner
private extension HomePresenter {
    
    /*
     * Perform network request
     */
    func requestNewPokemons(fromEndpoint endpoint: String) {
        guard let view = view else { return }
        view.startAnimating()
        service.getPokemonList(fromEndPoint: endpoint) { result in
            view.stopAnimating()
            switch result {
            case .success(let list):
                self.nextEndpoint = list.next
                self.defaults.set(list.next, forKey: App.DefaultKeys.next.rawValue)
                view.updateList(withData: list.results)
            case .failure(let error):
                view.stopAnimating()
                print("ANDONI: ", error)
                self.router?.presentAlert(onView: view, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }
    
    /*
     * Recovery saved list
     */
    func getSavedDate() {
        self.view?.stopAnimating()
        DispatchQueue.main.async {
            let results = self.coreDataManager.getRecentSearches()
            self.view?.updateList(replacingData: results)
        }
    }
}
