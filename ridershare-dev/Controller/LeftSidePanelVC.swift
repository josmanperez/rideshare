//
//  LeftSidePanelVC.swift
//  ridershare-dev
//
//  Created by Josman Pérez Expósito on 26/12/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {
    
    let currentUserId = Auth.auth().currentUser?.uid
    let appDelegate = AppDelegate.getAppDelegate()
    
    @IBOutlet var userEmailLbl: UILabel!
    @IBOutlet var userAccountTypeLbl: UILabel!
    @IBOutlet var userImageView: RoundImageView!
    @IBOutlet var pickupModeLbl: UILabel!
    @IBOutlet var pickUpModeSwitch: UISwitch!
    @IBOutlet var loginOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pickUpModeSwitch.isOn = false
        pickUpModeSwitch.isHidden = true
        pickupModeLbl.isHidden = true
        
        configureUser()
        
        observePassengerAndDriver()
        
    }
    
    func configureUser() {
        if let _ = Auth.auth().currentUser {
            userEmailLbl.text = Auth.auth().currentUser?.email
            userAccountTypeLbl.text = ""
            userImageView.isHidden = false
            loginOutBtn.setTitle("Logout", for: .normal)
        } else {
            userEmailLbl.text = ""
            userAccountTypeLbl.text = ""
            userImageView.isHidden = true
            loginOutBtn.setTitle("Sign Up / Login", for: .normal)
        }
    }
    
    func observePassengerAndDriver() {
        if let user = Auth.auth().currentUser?.uid {
            DataService.instance.REF_USERS.child(user).observeSingleEvent(of: .value, with: { (snapshot) in
                if let _ = snapshot.value as? String {
                    self.userAccountTypeLbl.text = "PASSENGER"
                }
            })
            DataService.instance.REF_DRIVERS.child(user).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDict = snapshot.value as? [String:Any] {
                    self.userAccountTypeLbl.text = "DRIVER"
                    self.pickUpModeSwitch.isHidden = false
                    self.pickupModeLbl.isHidden = false
                    if let switchStatus = userDict[LogInSigUp.isPickupModeEnabled] as? Bool {
                        self.pickUpModeSwitch.isOn = switchStatus
                        self.pickupModeLbl.text = switchStatus ? "PICKUP MODE ENABLED" : "PICUP MODE DISABLED"
                    } else {
                        self.pickUpModeSwitch.isEnabled = false
                    }
                }
            })
        }
    }
    
//    func observePassengersAndDrivers() {
//        DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
//            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
//                for snap in snapshots {
//                    if snap.key == Auth.auth().currentUser?.uid {
//                        self.userAccountTypeLbl.text = "PASSENGER"
//                    }
//                }
//            }
//        }
//        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value) { (snapshot) in
//            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
//                for snap in snapshots {
//                    if snap.key == Auth.auth().currentUser?.uid {
//                        self.userAccountTypeLbl.text = "DRIVER"
//                        self.pickUpModeSwitch.isHidden = false
//                        let switchStatus = snap.childSnapshot(forPath: LogInSigUp.isPickupModeEnabled).value as! Bool
//                        self.pickUpModeSwitch.isOn = switchStatus
//                        self.pickupModeLbl.isHidden = false
//                    }
//                }
//            }
//        }
//    }

    @IBAction func switchWasToggled(_ sender: Any) {
        guard let user = currentUserId else { return }
        if pickUpModeSwitch.isOn {
            pickupModeLbl.text = "PICKUP MODE ENABLED"
            DataService.instance.REF_DRIVERS.child(user).updateChildValues([LogInSigUp.isPickupModeEnabled:true])
        } else {
            pickupModeLbl.text = "PICKUP MODE DISABLED"
            DataService.instance.REF_DRIVERS.child(user).updateChildValues([LogInSigUp.isPickupModeEnabled:false])
        }
        appDelegate.menuContainerVC.toggleLeftPanel()
    }
    
    @IBAction func signUpLoginButtonWasPressed(_ sender: Any) {
        if let _ = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
                configureUser()
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            present(loginVC!, animated: true, completion: nil)
        }
    }
    
    
    
}
