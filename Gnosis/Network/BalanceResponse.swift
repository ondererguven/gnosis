//
//  BalanceResponse.swift
//  Gnosis
//
//  Created by Onder Erguven on 18.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import Foundation

struct BalanceResponse: Codable, ResponseDescribing {
    
    var status: String
    var message: String
    
    var amount: String
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case amount = "result"
    }
}
