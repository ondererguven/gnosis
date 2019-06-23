//
//  AccountViewController.swift
//  Gnosis
//
//  Created by Onder Erguven on 18.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Account"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addressLabel.text = user.address
        balanceLabel.text = "\(user.balance) Ether"
    }
    
    @IBAction func compose(_ sender: RoundedButton) {
        let messageComposeVC = self.storyboard?.instantiateViewController(withIdentifier: "MessageComposeVC") as! MessageComposeViewController
        messageComposeVC.user = user
        navigationController?.pushViewController(messageComposeVC, animated: true)
    }
    
    @IBAction func verify(_ sender: RoundedButton) {
        let messageVerifyVC = self.storyboard?.instantiateViewController(withIdentifier: "MessageVerifyVC") as! MessageVerifyViewController
        messageVerifyVC.user = user
        navigationController?.pushViewController(messageVerifyVC, animated: true)
    }
    
}
