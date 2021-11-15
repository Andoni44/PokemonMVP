//
//  HomeView.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import UIKit

final class HomeView: UIViewController {

    // MARK: Module components

    private var presenter: HomePresenterProtocol
    var dataSource: HomeDataSourceProtocol?

    // MARK: UI Outlets

    private let searchController = UISearchController(searchResultsController: nil)
    private let refresher: UIActivityIndicatorView = {
        let refresher = UIActivityIndicatorView()
        refresher.color = UIColor.green
        refresher.style = .large
        refresher.hidesWhenStopped = true
        return refresher
    }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: App.Colors.main.rawValue)
        table.register(PokemonTableViewCell.self, forCellReuseIdentifier: "cell")
        table.estimatedRowHeight = 150.0
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    // MARK: Core data

    private var allowNewRequest = true
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    // MARK: Data
    private var pokemonList: Results? {
        didSet {
            dataSource?.data = pokemonList
            pokemonListFiltered = pokemonList
            reloadData()
            pokemonMVPLog("Pokemon list presented 👁", level: .debug, tag: .presentation)
        }
    }
    private var pokemonListFiltered: Results? {
        didSet {
            DispatchQueue.main.async {
                if self.isFiltering {
                    self.dataSource?.data = self.pokemonListFiltered
                } else {
                    self.dataSource?.data = self.pokemonList
                }
            }
        }
    }

    // MARK: Life cycle

    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupFront()
        dataSource?.offsetControl = { [unowned self] bottomReached in
            DispatchQueue.main.async {
                if bottomReached && !isFiltering {
                    self.presenter.next()
                }
            }
        }
        presenter.didLoad()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        navigationItem.largeTitleDisplayMode = .always
        coordinator.animate(alongsideTransition: { (_) in
            self.navigationController?.navigationBar.sizeToFit()
        }, completion: nil)
        view.layoutIfNeeded()
    }
}

// MARK: - Inner

private extension HomeView {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Front

private extension HomeView {
    
    func setupFront() {
        searchSetup()
        navigationSetup()
        setupTable()
        setupLayout()
    }

    func setupTable() {
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        if let dataSource = dataSource as? UITableViewDataSource {
            tableView.dataSource = dataSource
        }
    }

    func searchSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "",
                                                                 attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        }
        /// TextField Color Customization
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.init(named: App.Colors.cell.rawValue)
            textfield.textColor = .white
        }

        searchController
            .searchBar
            .searchTextField
            .attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search any pokemon", comment: ""),
                                                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchController
            .searchBar
            .searchTextField
            .textColor = .white
    }

    func navigationSetup() {
        title = "All Pokemon!"
        navigationController?
            .navigationBar
            .barTintColor = UIColor(named: App.Colors.main.rawValue)
        navigationController?
            .navigationBar
            .titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: App.Colors.cell.rawValue) ?? UIColor.white,
                                    NSAttributedString.Key.font: UIFont(name: App.Fonts.antonRegular.rawValue,
                                                                        size: UIDevice.current.userInterfaceIdiom == .pad ? 23 : 20)!]
        navigationController?
            .navigationBar
            .largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                         NSAttributedString.Key.font: UIFont(name: App.Fonts.antonRegular.rawValue,
                                                                             size: UIDevice.current.userInterfaceIdiom == .pad ? 50 : 30)!]
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        let barBackItem = UIBarButtonItem(title: NSLocalizedString("All Pokemons", comment: ""), style: .plain,
                                          target: nil,
                                          action: nil)
        navigationItem.backBarButtonItem = barBackItem
    }

    func setupLayout() {
        [tableView, refresher].forEach {
            view.addSubview($0)
        }
        tableView
            .anchor(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                    trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor,
                    bottomAnchor: view.bottomAnchor,
                    leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor)
        refresher.translatesAutoresizingMaskIntoConstraints = false
        refresher.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        refresher.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

// MARK: - TableViewDelegate

extension HomeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let pokemonList = pokemonList,
            let pokemonListFiltered = pokemonListFiltered
        else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let url = self.isFiltering ? pokemonListFiltered[indexPath.item].url : pokemonList[indexPath.item].url
            self.presenter.showPokemonDetail(fromUrl: url, andUpdateList: pokemonList)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !tableView.isDecelerating {
            view.endEditing(true)
        }
    }
}

// MARK: - View output implementation

extension HomeView: HomeViewProtocol {

    func updateList(withData data: Results) {
        let list = pokemonList ?? []
        let newList = list + data
        self.pokemonList = newList
        presenter.saveList(newList)
        allowNewRequest = true
    }
    
    func updateList(replacingData data: Results) {
        self.pokemonList = data
        allowNewRequest = true
    }
    
    func startAnimating() {
        DispatchQueue.main.async {
            self.refresher.startAnimating()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.refresher.stopAnimating()
        }
    }
    
    func getPokemonData() -> Results {
        guard let results = pokemonList else { return [] }
        return results
    }
}

//MARK: - HomeView Search bar extension

extension HomeView: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let pokemonList = pokemonList else { return }
        self.pokemonListFiltered = pokemonList.filter { [weak self] (character: PokemonResultElement) -> Bool in
            guard let self = self else { return false }
            if character
                .name
                .lowercased()
                .contains(self.searchController.searchBar.text!.lowercased()) {
                return true
            } else{
                return false
            }
        }
        reloadData()
    }
}

#if DEBUG

import SwiftUI

struct PreviewHome: PreviewProvider {
    
    static var previews: some View {
        let vc = HomeRouter().viewController
        return vc.view.instaView.edgesIgnoringSafeArea(.all)
    }
}

#endif
