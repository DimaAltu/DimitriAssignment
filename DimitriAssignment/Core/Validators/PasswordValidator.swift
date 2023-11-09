//
//  PasswordValidator.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 08.11.23.
//

protocol PasswordValidator {
    func validatePassword(password: String) -> Bool
}

struct PasswordValidatorImpl: PasswordValidator {
    func validatePassword(password: String) -> Bool {
        (6...12).contains(password.count)
    }
}
