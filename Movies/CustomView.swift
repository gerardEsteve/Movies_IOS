//
//  CustomView.swift
//  Movies
//
//  Created by curs on 4/2/19.
//  Copyright © 2019 curs. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
           // self.priceLabel.text = "nuevo precio"
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    
}
