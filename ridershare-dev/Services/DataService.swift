//
//  DataService.swift
//  ridershare-dev
//
//  Created by Josman Pérez Expósito on 27/12/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE: DatabaseReference! = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE    = DB_BASE
    private var _REF_USERS   = DB_BASE.child(databaseTypes.users.rawValue)
    private var _REF_DRIVERS = DB_BASE.child(databaseTypes.drviers.rawValue)
    private var _REF_TRIPS   = DB_BASE.child(databaseTypes.trips.rawValue)
    
    var REF_BASE: DatabaseReference? {
        return _REF_BASE
    }
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    var REF_DRIVERS: DatabaseReference {
        return _REF_DRIVERS
    }
    var REF_TRIPS: DatabaseReference {
        return _REF_TRIPS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, Any>, isDriver: Bool) {
        if isDriver {
            REF_DRIVERS.child(uid).updateChildValues(userData)
        } else {
            REF_USERS.child(uid).updateChildValues(userData)
        }
    }
}

extension DataService {
    fileprivate enum databaseTypes:String {
        case users   = "users"
        case drviers = "drivers"
        case trips   = "trips"
    }
}
