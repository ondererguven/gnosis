//
//  SetupViewController.swift
//  Gnosis
//
//  Created by Onder Erguven on 17.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var responseLabel: UILabel!
    
    @IBAction func getBalance(_ sender: UIButton) {
        let balanceRequest = BalanceRequest(address: addressTextField.text!)
        
        let networkOperator = NetworkOperator()
        networkOperator.execute(request: balanceRequest)
        { (data) in
            DispatchQueue.main.async {
                self.responseLabel.text = "\(data)"
            }
        }
    }
}
