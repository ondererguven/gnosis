//
//  Router.swift
//  Gnosis
//
//  Created by Onder Erguven on 20.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import Foundation
import web3swift

class Router: NSObject {
    
    static let shared = Router()
    
    private static let apiKey = "WQUKAN7KFV9E16EAIS5NHZ76JX4ZFGBQ74"
    
    private var web3Instance: Web3
    
    private override init() {
        web3Instance = Web3(infura: .rinkeby, accessToken: Router.apiKey)
        
        super.init()
    }
    
    func getBalance(address: String, completion: @escaping ((String?) -> ())) {
        DispatchQueue.global().async {
            do {
                let address = Address(address)
                let balance = try self.web3Instance.eth.getBalance(address: address)
                let formattedBalance = Web3Utils.formatToEthereumUnits(balance)
                completion(formattedBalance)
            } catch {
                completion(nil)
            }
        }
    }
    
}
