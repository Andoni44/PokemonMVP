//
//  Pokemon.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    let id: Int
    let name: String
    let baseExperience, height: Int
    let isDefault: Bool
    let order: Int
    let abilities: [Ability]
    let species: AbilityData
    let types: [TypeElement]
    let sprites: Sprites?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order, abilities
        case species, types, sprites
    }
}

// MARK: - Sprites
class Sprites: Codable {
    let frontDefault: String
    let animated: Sprites?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case animated
    }
}

// MARK: - Ability
struct Ability: Codable {
    let isHidden: Bool
    let slot: Int
    let ability: AbilityData
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot, ability
    }
}

// MARK: - Species
struct AbilityData: Codable {
    let name: String
    let url: String
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: Type
}

// MARK: - Type
struct Type: Codable {
    let url: String
    let name: TypeName
}

// MARK: - TypeName
enum TypeName: String, Codable {
    
    func returnTypeColor() -> TypeColor {
        return TypeColor(rawValue: self.rawValue) ?? .normal
    }
    
    case fire, water, normal, grass, flying, fighting, poison,
         electric, ground, rock, psychic, ice, bug, ghost,
         steel, dragon, dark, fairy
}

enum TypeColor: String{
    
    case fire, water, normal, grass, flying, fighting, poison,
         electric, ground, rock, psychic, ice, bug, ghost,
         steel, dragon, dark, fairy
}

typealias PokemonResults = [Pokemon]
