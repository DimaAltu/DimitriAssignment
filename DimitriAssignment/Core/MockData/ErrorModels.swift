//
//  ErrorModels.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 07.11.23.
//

import Foundation

extension Input.ErrorTextViewModel {
    static var emailNotValid: Input.ErrorTextViewModel {
        .init(errorText: "არასწორი ემაილი", errorTextColor: .red)
    }
    
    static var emailNotExists: Input.ErrorTextViewModel {
        .init(errorText: "ასეთი ემაილი არ არსებობს", errorTextColor: .red)
    }
    
    static var incorrectPassword: Input.ErrorTextViewModel {
        .init(errorText: "არასწორი პაროლი", errorTextColor: .red)
    }
    
    static var passwordInvalidCount: Input.ErrorTextViewModel {
        .init(errorText: "პაროლი უნდა იყო მინიმუმ 6 და მაქსიმუმ 12 სიმბოლო", errorTextColor: .red)
    }
    
    static var invalidAge: Input.ErrorTextViewModel {
        .init(errorText: "ასაკი უნდა იყოს მინიმუმ 18 და მაქსიმუმ 99", errorTextColor: .red)
    }
}
