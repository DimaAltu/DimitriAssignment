//
//  EmailValidator.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 08.11.23.
//

import Foundation

protocol EmailValidator {
    func isEmailValid(email: String) -> Bool
}

struct EmailValidatorImpl: EmailValidator {
    func isEmailValid(email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
    }
}
