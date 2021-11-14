//
//  Helper.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import UIKit

struct Helper {

    static private let decoder = JSONDecoder()
    
    static func decode<T: Decodable>(_ data: Data, completion: @escaping ((T) -> Void)) {
        do {
            let model = try decoder.decode(T.self, from: data)
            completion(model)
            } catch let DecodingError.dataCorrupted(context) {
                pokemonMVPLog(DecodingError.dataCorrupted(context),
                              message: context.debugDescription,
                              tag: .decoding)
            } catch let DecodingError.keyNotFound(key, context) {
                pokemonMVPLog(DecodingError.keyNotFound(key, context),
                              message: "Key '\(key)' not found:, \(context.debugDescription). codingPath: \(context.codingPath) 🚨",
                              tag: .decoding)
            } catch let DecodingError.valueNotFound(value, context) {
                pokemonMVPLog(DecodingError.valueNotFound(value, context),
                              message: "Value '\(value)' not found:, \(context.debugDescription). codingPath: \(context.codingPath) 🚨",
                              tag: .decoding)
            } catch let DecodingError.typeMismatch(type, context)  {
                pokemonMVPLog(DecodingError.typeMismatch(type, context),
                              message: "Type '\(type)' mismatch:, \(context.debugDescription). codingPath: \(context.codingPath) 🚨",
                              tag: .decoding)
            } catch let error {
                pokemonMVPLog(error,
                              message: "Error decoding json 🚨",
                              tag: .decoding)
            }
    }
}
