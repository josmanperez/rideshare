//
//  Error.swift
//  ridershare-dev
//
//  Created by Josman Pérez Expósito on 28/12/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import Foundation

enum AuthError: Error {
    case emailInvalid
    case emailAlreadyInUse
    case wrongPassword
    case other

    func showErrorMessage() -> String {
        switch self {
        case .emailInvalid:
            return "Email invalid. Please try again."
        case .emailAlreadyInUse:
            return "That email is already in use. Please try again"
        case .wrongPassword:
            return "Whoops! That was the wrong password"
        case .other:
            return "An unexpected error occured. Please try again"
        }
    }
}
