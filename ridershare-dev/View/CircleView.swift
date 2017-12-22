//
//  CircleView.swift
//  ridershare-dev
//
//  Created by Josman Pérez Expósito on 14/12/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
    }
    
    

}
