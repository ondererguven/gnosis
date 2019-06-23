//
//  QRGenerator.swift
//  Gnosis
//
//  Created by Onder Erguven on 23.06.2019.
//  Copyright © 2019 Onder Erguven. All rights reserved.
//

import UIKit

final class QRGenerator {
    
    static func generate(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
}
