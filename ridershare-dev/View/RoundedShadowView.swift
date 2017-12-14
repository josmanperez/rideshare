//
//  RoundedShadowView.swift
//  ridershare-dev
//
//  Created by Josman Pérez Expósito on 14/12/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {
    
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }

    func setupView() {
        self.layer.cornerRadius  = Constant.box_light_corner_radius
        // Shadow
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor   = UIColor.darkGray.cgColor
        self.layer.shadowRadius  = 5.0
        self.layer.shadowOffset  = CGSize(width: 0, height: 5)
    }

}
