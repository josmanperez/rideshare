//
//  GradientView.swift
//  ridershare-dev
//
//  Created by Josman Pérez Expósito on 14/12/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        setUpGradientView()
        super.awakeFromNib()
    }
    
    func setUpGradientView() {
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1) // 1 means 100%
        gradient.locations = [0.8, 1.0] // First color starts at 80%
        self.layer.addSublayer(gradient)
    }

}
