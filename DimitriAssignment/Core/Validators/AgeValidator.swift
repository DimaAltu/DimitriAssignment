//
//  AgeValidator.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 08.11.23.
//

protocol AgeValidator {
    func validateAge(age: Int) -> Bool
}

struct AgeValidatorImpl: AgeValidator {
    func validateAge(age: Int) -> Bool {
        (18...99).contains(age)
    }
}
