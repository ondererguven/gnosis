//
//  Network.swift
//  Gnosis
//
//  Created by Onder Erguven on 17.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum TransferProtocol: String {
    case http = "http"
    case https = "https"
}

enum QueryParameter: String {
    case module = "module"
    case action = "action"
    case address = "address"
    case tag = "tag"
    case apiKey = "apikey"
}

protocol RequestDescribing {
    var transferProtocol: TransferProtocol { get set }
    var baseURL: String { get set }
    var queryItems: [QueryParameter : String]? { get set }
    
    func buildURL() -> URL?
}

struct NetworkOperator {
    static let baseURL = "api-rinkeby.etherscan.io"
    static let apiKey = "WQUKAN7KFV9E16EAIS5NHZ76JX4ZFGBQ74"
    
    init() { }
    
    func execute(request: RequestDescribing, completion: @escaping (([String : Any]?) -> Void)) {
        guard let requestURL = request.buildURL() else {
            completion(nil)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (responseData, urlResponse, requestError) in
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: responseData!, options: .allowFragments) as! [String : Any]
                
                completion(jsonData)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
}

