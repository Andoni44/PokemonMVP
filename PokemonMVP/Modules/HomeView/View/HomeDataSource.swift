//
//  HomeDataSource.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import UIKit

final class HomeDataSource: NSObject {
    
    var data: Results?
    var offset: Int = 20
    var offsetControl: ((Bool) -> ())?
}

extension HomeDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PokemonTableViewCell,
                let data = data
        else { return UITableViewCell() }
        cell.pokemonName = data[indexPath.item].name
        if indexPath.item == data.count - 1{
            if let getMoreItems = offsetControl {
                getMoreItems(true)
            }
        }
        return cell
    }
}

// MARK: - HomeDataSource

extension HomeDataSource: HomeDataSourceProtocol {
    
}

protocol HomeDataSourceProtocol: AnyObject {
    
    var data: Results? { get set }
    var offset: Int { get set }
    var offsetControl: ((Bool) -> ())? { get set }
}
