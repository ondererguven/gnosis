//
//  MessageComposeViewController.swift
//  Gnosis
//
//  Created by Onder Erguven on 20.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import UIKit

class MessageComposeViewController: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var qrImageView: UIImageView!
    
    var signButton: UIBarButtonItem!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signButton = UIBarButtonItem(title: "Sign",
                                     style: .plain,
                                     target: self,
                                     action: #selector(signMessage(_:)))
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = signButton

        messageTextView.becomeFirstResponder()
    }
    
    @objc func signMessage(_ sender: UIBarButtonItem) {
        messageTextView.resignFirstResponder()
        
        guard let text = messageTextView.text else { return }
        
        Router.shared.signMessage(text: text,
                                  user: user)
        { [weak self] (signedMessageData) in
            guard let data = signedMessageData else { return }
            
            let signedMessage = "0x\(data.hex)"
            
            guard let messageQR = QRGenerator.generate(from: signedMessage) else {
                return
            }
            
            DispatchQueue.main.async {
                self?.qrImageView.image = messageQR
            }
        }
    }
    
}
