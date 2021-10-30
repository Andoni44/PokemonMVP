//
//  HomePresenterTests.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 21/2/21.
//

import XCTest

class HomePresenterServiceTests: XCTestCase {

    var mockURLSession: MockURLSession!
    var sut: HomePresenterProtocol!

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        let remoteDataSource = ApiFactory(session: mockURLSession)
        let router: HomeRouterTestDouble = HomeRouterTestDouble()
        sut = HomePresenter(router: router, remoteDataSource: remoteDataSource)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockURLSession = nil
    }
    
    func test_dataTask_execute() {
        sut.remoteDataSource.session.dataTask(with: URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon")!), completionHandler: { (data, response, error) in
            
        }).resume()
        if let sess = sut.remoteDataSource.session as? MockURLSession {
            XCTAssertEqual(sess.dataTaskCallCount, 1, "call count")
        }
    }
    
    func test_fetch_results() {
        sut.remoteDataSource.session = URLSession.shared
        var listCount = 0
        let expectation = self.expectation(description: "Expecting 20 pokemons")
        sut.remoteDataSource.getData(fromEndPoint: "https://pokeapi.co/api/v2/pokemon") { (result: Result<PokemonList, NetworkError>) in
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
        sut.remoteDataSource.session = URLSession.shared
        var name = ""
        let expectation = self.expectation(description: "Expecting Bulbasaur")
        sut.remoteDataSource.getData(fromEndPoint: "https://pokeapi.co/api/v2/pokemon/1/") { (result: Result<Pokemon, NetworkError>) in
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
