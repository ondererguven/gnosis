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
    
    @IBOutlet weak var privateKeyTextView: UITextView!
    
    var user = User(privateKey: "", address: "", balance: "")
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        privateKeyTextView.becomeFirstResponder()
    }
    
    @IBAction func setup(_ sender: RoundedButton) {
        guard let privateKeyText = privateKeyTextView.text else { return }
        
        sender.isUserInteractionEnabled = false
        
        user.privateKey = privateKeyText
        
        do {
            try Router.shared.setKeytore(for: user)
            
            guard let address = Router.shared.getAddress() else {
                sender.isUserInteractionEnabled = true
                return
            }
            
            user.address = address
            
            Router.shared.getBalance(address: user.address)
            { [weak self] (balance) in
                DispatchQueue.main.async {
                    guard let balance = balance else {
                        sender.isUserInteractionEnabled = true
                        self?.presentAlert()
                        return
                    }
                    
                    self?.user.balance = balance
                    
                    self?.presentAccountViewController()
                }
            }
        } catch {
            debugPrint(error)
        }
    }
    
    private func presentAccountViewController() {
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
