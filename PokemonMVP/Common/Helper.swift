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
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("Error decoding data")
            }
    }
}
