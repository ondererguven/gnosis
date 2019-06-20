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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never

        messageTextView.becomeFirstResponder()
    }

}
