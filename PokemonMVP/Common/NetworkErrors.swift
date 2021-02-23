//
//  NetworkErrors.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 22/2/21.
//

import Foundation

enum NetworkError: Error {
    case noNetwork
    case problem
    case error
    case serverError
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noNetwork:
            return NSLocalizedString("Check your internet connection", comment: "")
        case .problem:
            return NSLocalizedString("There is a problem with your request", comment: "")
        case .error:
            return NSLocalizedString("Error", comment: "")
        case .serverError:
            return NSLocalizedString("Error with the server", comment: "")
        }
    }
}
