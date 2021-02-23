//
//  PokemonList.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

// MARK: - PokemonList
struct PokemonList: Codable {
    let count: Int
    let next, previous: String?
    let results: [PokemonResultElement]
}

// MARK: - Result
struct PokemonResultElement: Codable {
    let name: String
    let url: String
}

typealias Results = [PokemonResultElement]
