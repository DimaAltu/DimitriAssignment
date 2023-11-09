//
//  RegistrationGateway.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 09.11.23.
//

protocol RegistrationGateway {
    func registerUser(requestModel: RegisterRequest) async throws -> Bool
}

struct ApiRegistrationGateway: RegistrationGateway {
    func registerUser(requestModel: RegisterRequest) async throws -> Bool {
        return true
    }
}
