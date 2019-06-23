//
//  MessageVerifyViewController.swift
//  Gnosis
//
//  Created by Onder Erguven on 23.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import UIKit

class MessageVerifyViewController: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!
    
    var verifyButton: UIBarButtonItem!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        verifyButton = UIBarButtonItem(title: "Verify",
                                     style: .plain,
                                     target: self,
                                     action: #selector(verifyMessage(_:)))
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = verifyButton
        
        messageTextView.becomeFirstResponder()
    }

    @objc func verifyMessage(_ sender: UIBarButtonItem) {
        messageTextView.resignFirstResponder()
        
        guard let text = messageTextView.text else { return }
        
        goToQRReader(message: text)
    }
    
    private func goToQRReader(message: String) {
        let cameraVC = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") as! CameraViewController
        cameraVC.message = message
        cameraVC.user = user
        navigationController?.pushViewController(cameraVC, animated: true)
    }
}
