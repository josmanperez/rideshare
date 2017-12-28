//
//  LoginVC.swift
//  ridershare-dev
//
//  Created by Josman Pérez Expósito on 26/12/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailField: RoundedCornerTextField!
    @IBOutlet var passwordField: RoundedCornerTextField!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var authButton: RoundedShadowButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        emailField.delegate = self
        passwordField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelButtonWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func authButtonWasPressed(_ sender: Any) {
        if emailField.text != "" && passwordField.text != "" {
            self.view.endEditing(true)
            authButton.animateButton(shouldLoad: true, withMessage: nil)
            
            if let email = emailField.text, let password = passwordField.text {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {
                        // The user is already created
                        if let user = user {
                            if self.segmentedControl.selectedSegmentIndex == 0 {
                                let userData = ["provider": user.providerID] as [String:Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                            } else {
                                let userData = [
                                    LogInSigUp.provider:user.providerID,
                                    LogInSigUp.userIsDriver : true,
                                    LogInSigUp.isPickupModeEnabled:false,
                                    LogInSigUp.driverIsOnTrip:false
                                    ] as [String:Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                            }
                        }
                        print("Email user authenticated succesfully with firebase")
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        if let e = error as NSError? {
                            guard let errorCode = AuthErrorCode(rawValue: e.code) else { return }
                            switch errorCode {
                            case .wrongPassword:
                                print("Whoops! that was the wrong password")
                            default:
                                print("An unexpected error ocurred. Please try again")
                            }
                        }
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                if let error = error as NSError? {
                                    if let errorCode = AuthErrorCode(rawValue: error.code) {
                                        switch errorCode {
                                        case .emailAlreadyInUse:
                                            print("Email already in use. Please try again")
                                        case .invalidEmail:
                                            print("That is an invalid email!. Please try again.")
                                        default:
                                            print("An unexpected error ocurred. Please try again")
                                        }
                                    }
                                }
                            } else {
                                if let user = user {
                                    if self.segmentedControl.selectedSegmentIndex == 0 {
                                        let userData = ["provider":user.providerID] as [String:Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                                    } else {
                                        let userData = [
                                            LogInSigUp.provider:user.providerID,
                                            LogInSigUp.userIsDriver : true,
                                            LogInSigUp.isPickupModeEnabled:false,
                                            LogInSigUp.driverIsOnTrip:false
                                            ] as [String:Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                                    }
                                }
                                print("Succesfully created a new user with Firebase")
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
        }
    }
}


