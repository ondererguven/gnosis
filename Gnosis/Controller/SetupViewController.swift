//
//  SetupViewController.swift
//  Gnosis
//
//  Created by Onder Erguven on 17.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    
    @IBOutlet weak var addressTextView: UITextView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addressTextView.becomeFirstResponder()
    }
    
    @IBAction func setup(_ sender: RoundedButton) {
        guard let text = addressTextView.text else { return }
        
        let balanceRequest = BalanceRequest(address: text)
        
        NetworkOperator().execute(request: balanceRequest)
        { (result) in
            switch result {
            case .success(let data):
                do {
                    let balanceResponse = try JSONDecoder().decode(BalanceResponse.self,
                                                                   from: data)
                    
                    if balanceResponse.message == "OK" && balanceResponse.status == "1" {
                        let account = Account(address: text,
                                              balance: balanceResponse.amount)
                        debugPrint(account)
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Oops", message: "Check the address please", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK",
                                                         style: .default,
                                                         handler: nil)
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    
                } catch {
                    debugPrint(error)
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
