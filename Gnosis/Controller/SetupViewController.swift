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
        
        NetworkOperator().execute(request: balanceRequest) { [weak self] (result) in
            switch result {
            case .success(_):
                do {
                    let balance = try result.decodedObject() as Balance
                    let account = Account(address: text,
                                          balance: balance)
                    
                    let accountVC = self?.storyboard?.instantiateViewController(withIdentifier: "AccountVC") as! AccountViewController
                    accountVC.account = account
                    let navigationVC = UINavigationController(rootViewController: accountVC)
                    navigationVC.navigationBar.barStyle = .blackOpaque
                    navigationVC.navigationBar.barTintColor = UIColor(white: 0.1, alpha: 1.0)
                    navigationVC.navigationBar.isTranslucent = false
                    navigationVC.navigationBar.prefersLargeTitles = true
                    
                    DispatchQueue.main.async {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = navigationVC
                    }
                } catch {
                    debugPrint(error)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Oops", message: "Check the address please", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK",
                                                 style: .default,
                                                 handler: nil)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                }
                debugPrint(error)
            }
        }
    }
}
