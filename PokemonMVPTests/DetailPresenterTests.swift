//
//  DetailPresenterTests.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 21/2/21.
//

import XCTest

class DetailPresenterTests: XCTestCase {

    let sut = DetailPresenter()
    let pokemon = Pokemon(id: 2, name: "ivysaur", baseExperience: 142, height: 10, isDefault: true, order: 2, abilities: [Ability(isHidden: false, slot: 1, ability: AbilityData(name: "overgrow", url: "https://pokeapi.co/api/v2/ability/65/")), Ability(isHidden: true, slot: 3, ability: AbilityData(name: "chlorophyll", url: "https://pokeapi.co/api/v2/ability/34/"))], species: AbilityData(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon-species/2/"), types: [TypeElement(slot: 1, type: Type(url: "https://pokeapi.co/api/v2/type/12/", name: TypeName.grass)), TypeElement(slot: 2, type: Type(url: "https://pokeapi.co/api/v2/type/4/", name: TypeName.poison))], sprites: nil)
    
    func test_return_types() {
        let types = sut.returnTypes(pokemon: pokemon)
        XCTAssertEqual(types.count, 2)
        XCTAssertEqual(types[0], TypeName.grass)
        XCTAssertEqual(types[1], TypeName.poison)
    }
    
    func test_return_abilities() {
        let abilities = sut.returnAbilitiesNames(pokemon: pokemon)
        XCTAssertEqual(abilities.count, 2)
        XCTAssertEqual(abilities[0], "overgrow")
        XCTAssertEqual(abilities[1], "chlorophyll")
    }
    
    func test_pokemon_removal() {
        let view: DetailViewProtocol = DetailView()
        sut.view = view
        view.presenter = sut
        let results: Results = [PokemonResultElement(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")]
        var dataTotal = 12
        let action = {
            let newData = results.filter{ $0.name != self.pokemon.name }
            dataTotal = newData.count
        }
        view.deleteAction = action
        sut.removePokemon(name: pokemon.name)
        XCTAssertEqual(dataTotal, 0, "number of pokemons")
    }
}
