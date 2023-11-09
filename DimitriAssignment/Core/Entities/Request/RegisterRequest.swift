//
//  RegisterRequest.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 09.11.23.
//

struct RegisterRequest: Encodable {
    let email: String
    let password: String
    let age: Int
}
