//
//  Balance.swift
//  Gnosis
//
//  Created by Onder Erguven on 20.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import Foundation

struct Balance: Codable {
    
    var amount: String
    
    enum CodingKeys: String, CodingKey {
        case amount = "result"
    }
}
