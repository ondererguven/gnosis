//
//  Network.swift
//  Gnosis
//
//  Created by Onder Erguven on 17.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import Foundation

enum TransferProtocol: String {
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

enum RequestError: Error {
    case badURL
}

enum ResponseError: Error {
    case responseError
    case noData
}

struct NetworkOperator {
    static let baseURL = "api-rinkeby.etherscan.io"
    static let apiKey = "WQUKAN7KFV9E16EAIS5NHZ76JX4ZFGBQ74"
    
    init() { }
    
    func execute(request: RequestDescribing,
                 completion: @escaping ((Result<Data, Error>) -> Void))
    {
        guard let requestURL = request.buildURL() else {
            completion(.failure(RequestError.badURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(ResponseError.responseError))
                return
            }
            
            guard let data = data else {
                completion(.failure(ResponseError.noData))
                return
            }
            
            completion(.success(data))
        }
        
        dataTask.resume()
    }
}

