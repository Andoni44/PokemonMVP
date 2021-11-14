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
    private var router: HomeRouterProtocol
    
    var remoteDataSource: ApiFactoryProtocol
    private var nextEndpoint: String?
    private let defaults: UserDefaults
    private let localDataSource: CoreDataManagerProtocol

    init(router: HomeRouterProtocol,
         coreDataManager: CoreDataManagerProtocol = CoreDataManager(),
         defaults: UserDefaults = UserDefaults.standard,
         remoteDataSource: ApiFactoryProtocol = ApiFactory()) {
        self.router = router
        self.localDataSource = coreDataManager
        self.defaults = defaults
        self.remoteDataSource = remoteDataSource
    }
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
            requestNewPokemons(fromEndpoint: remoteDataSource.endPoint)
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

        remoteDataSource.getData(fromEndPoint: url) { [weak self] (result: Result<Pokemon, NetworkError>) in
            guard let view = self?.view, let self = self else { return }
            view.stopAnimating()
            switch result {
            case .success(let pokemon):
                    pokemonMVPLog("Pokemon detail loaded successfully 📡", level: .debug, tag: .networking)
                let action = {
                    let newData = list.filter{ $0.name != pokemon.name }
                    view.updateList(replacingData: newData)
                }
                self.router.pushDetailView(fromView: view, presentData: pokemon, deleteAction: action)
            case .failure(let error):
                pokemonMVPLog(error, message: "Pokemon detail failed 🚨", tag: .networking)
                self.router.presentAlert(onView: view, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }
    
    func saveList(_ list: Results) {
        DispatchQueue.main.async { [weak self] in
            self?.localDataSource.saveData(results: list)
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
        remoteDataSource.getData(fromEndPoint: endpoint) { (result: Result<PokemonList, NetworkError>) in
            view.stopAnimating()
            switch result {
            case .success(let list):
                pokemonMVPLog("New pokemons loaded successfully 📡", level: .debug, tag: .networking)
                self.nextEndpoint = list.next
                self.defaults.set(list.next, forKey: App.DefaultKeys.next.rawValue)
                view.updateList(withData: list.results)
            case .failure(let error):
                view.stopAnimating()
                self.router.presentAlert(onView: view, withTitle: "Error", andMessage: error.localizedDescription)
            }
        }
    }
    
    /*
     * Recovery saved list
     */
    func getSavedDate() {
        self.view?.stopAnimating()
        DispatchQueue.main.async { [weak self] in
            guard let results = self?.localDataSource.getRecentSearches() else { return }
            self?.view?.updateList(replacingData: results)
        }
    }
}
