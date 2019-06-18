//
//  RoundedButton.swift
//  Gnosis
//
//  Created by Onder Erguven on 18.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }

}
