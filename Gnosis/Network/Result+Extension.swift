//
//  Result+Extension.swift
//  Gnosis
//
//  Created by Onder Erguven on 20.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import Foundation

extension Result where Success == Data {
    
    func decodedObject<T: Decodable>() throws -> T {
        do {
            let data = try get()
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw(error)
        }
    }
    
    func decodedArray<T: Decodable>() throws -> [T] {
        do {
            let data = try get()
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            throw(error)
        }
    }
    
}
