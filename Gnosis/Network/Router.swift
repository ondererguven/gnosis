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
    
    enum PrivateKeyError: String, Error {
        case unableToConvert
    }
    
    enum KeystoreError: String, Error {
        case unableToAccessKeystore
    }
    
    static let shared = Router()
    
    private static let apiKey = "WQUKAN7KFV9E16EAIS5NHZ76JX4ZFGBQ74"
    
    private var web3Instance: Web3
    
    private override init() {
        self.web3Instance = Web3(infura: .rinkeby, accessToken: Router.apiKey)
        
        super.init()
    }
    
    func setKeytore(for user: User) throws {
        let privateKey = user.privateKey
        
        guard let privateKeyData = Data.fromHex(privateKey) else {
            throw(PrivateKeyError.unableToConvert)
        }
        
        do {
            let keystore = try EthereumKeystoreV3(privateKey: privateKeyData,
                                                  password: "")
            guard let unwrappedKeystore = keystore else {
                throw(KeystoreError.unableToAccessKeystore)
            }
            let keystoreManager = KeystoreManager([unwrappedKeystore])
            self.web3Instance.keystoreManager = keystoreManager
        } catch {
            throw(error)
        }
    }
    
    func getAddress() -> String? {
        guard let address = self.web3Instance.keystoreManager.addresses.first else { return nil
        }
        
        return address.address
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
    
    func signMessage(text: String,
                     user: User,
                     completion: @escaping((Data?) -> ())) {
        let data = text.data(using: .utf8)!
        let account = Address(user.address)
        
        do {
            let signedData = try Web3Signer.signPersonalMessage(data, keystore: self.web3Instance.keystoreManager, account: account, password: "")
            
            completion(signedData)
        } catch {
            debugPrint(error)
            
            completion(nil)
        }
    }
    
    func verifyMessage(text: String,
                       signedData: Data,
                       user: User,
                       completion: @escaping((Bool) -> ())) {
        let data = text.data(using: .utf8)!
        
        do {
            let addr = try Web3Utils.personalECRecover(data,
                                                       signature: signedData)
            
            completion(user.address == addr.address)
        } catch {
            debugPrint(error)
            
            completion(false)
        }
    }
}
