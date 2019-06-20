//
//  SetupViewController.swift
//  Gnosis
//
//  Created by Onder Erguven on 17.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import UIKit
import web3swift

class SetupViewController: UIViewController {
    
    @IBOutlet weak var addressTextView: UITextView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addressTextView.becomeFirstResponder()
    }
    
    @IBAction func setup(_ sender: RoundedButton) {
        guard let text = addressTextView.text else { return }
        
        sender.isUserInteractionEnabled = false
        
        Router.shared.getBalance(address: text) { [weak self] (balance) in
            DispatchQueue.main.async {
                guard let balance = balance else {
                    sender.isUserInteractionEnabled = true
                    self?.presentAlert()
                    return
                }
                
                self?.presentAccountViewController(address: text, balance: balance)
            }
        }
    }
    
    private func presentAccountViewController(address: String, balance: String) {
        let user = User(address: address, balance: balance)
        
        let accountVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountVC") as! AccountViewController
        accountVC.user = user
        let navigationVC = UINavigationController(rootViewController: accountVC)
        navigationVC.navigationBar.barStyle = .blackOpaque
        navigationVC.navigationBar.barTintColor = UIColor(white: 0.1, alpha: 1.0)
        navigationVC.navigationBar.isTranslucent = false
        navigationVC.navigationBar.prefersLargeTitles = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navigationVC
    }
    
    private func presentAlert() {
        let alertController = UIAlertController(title: "Oops", message: "Check the address please", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
