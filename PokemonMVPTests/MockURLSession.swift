//
//  PokemonMVPTests.swift
//  PokemonMVPTests
//
//  Created by Andoni Da silva on 19/2/21.
//

import Foundation

final class MockURLSession: URLSessionProtocol {
    var dataTaskCallCount = 0
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        return DummyURLSessionDataTask()
    }
    
    private class DummyURLSessionDataTask: URLSessionDataTask {
        override func resume() {
            
        }
    }
}
