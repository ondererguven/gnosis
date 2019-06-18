//
//  BalanceRequest.swift
//  Gnosis
//
//  Created by Onder Erguven on 17.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import Foundation

struct BalanceRequest: RequestDescribing {
    
    var transferProtocol: TransferProtocol
    var baseURL: String
    var queryItems: [QueryParameter : String]?
    
    init(transferProtocol: TransferProtocol = .https,
         baseURL: String = NetworkOperator.baseURL,
         address: String) {
        self.baseURL = baseURL
        self.transferProtocol = transferProtocol
        self.queryItems = [
            QueryParameter.module : "account",
            QueryParameter.action : "balance",
            QueryParameter.address : address,
            QueryParameter.tag : "latest",
            QueryParameter.apiKey : NetworkOperator.apiKey
        ]
    }
    
    func buildURL() -> URL? {
        var components = URLComponents()
        components.scheme = transferProtocol.rawValue
        components.host = baseURL
        components.path = "/api"
        
        if let queryItems = self.queryItems {
            var items = [URLQueryItem]()
            
            for item in queryItems {
                let urlQueryItem = URLQueryItem(name: item.key.rawValue,
                                                value: item.value)
                items.append(urlQueryItem)
            }
            
            components.queryItems = items
        }
        
        guard let url = components.url else { return nil }
        return url
    }
    
}
