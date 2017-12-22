//
//  ViewController.swift
//  ridershare-dev
//
//  Created by Josman Pérez Expósito on 13/12/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var actionButton: RoundedShadowButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }

    @IBAction func actionButtonWasPressed(_ sender: RoundedShadowButton) {
        actionButton.animateButton(shouldLoad: true, withMessage: nil)
    }
}

