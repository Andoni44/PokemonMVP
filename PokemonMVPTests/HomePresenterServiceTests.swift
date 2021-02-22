//
//  HomePresenterTests.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 21/2/21.
//

import XCTest

class HomePresenterServiceTests: XCTestCase {

    let mockURLSession = MockURLSession()
    let sut = HomePresenter()
    
    func test_dataTask_execute() {
        sut.session = mockURLSession
        sut.session?.dataTask(with: URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon")!), completionHandler: { (data, response, error) in
            
        }).resume()
        if let sess = sut.session as? MockURLSession {
            XCTAssertEqual(sess.dataTaskCallCount, 1, "call count")
        }
    }
    
    func test_fetch_results() {
        sut.session = URLSession.shared
        var listCount = 0
        let expectation = self.expectation(description: "Expecting 20 pokemons")
        sut.service.getPokemonList(fromEndPoint: "https://pokeapi.co/api/v2/pokemon") { result in
            switch result {
            case .success(let list):
                listCount = list.results.count
                expectation.fulfill()
            case .failure:
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(listCount, 20, "number of first results")
    }
    
    func test_fetch_pokemon_details() {
        sut.session = URLSession.shared
        var name = ""
        let expectation = self.expectation(description: "Expecting Bulbasaur")
        sut.service.getPokemonDetail(fromEndPoint: "https://pokeapi.co/api/v2/pokemon/1/") { result in
            switch result {
            case .success(let pokemon):
                name = pokemon.name
                expectation.fulfill()
            case .failure:
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(name, "bulbasaur", "first pokemon name: bulbasaur")
    }
}
