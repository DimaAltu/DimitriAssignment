//
//  LoginGateway.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 09.11.23.
//

protocol LoginGateway {
    func loginUser(requestModel: LoginRequest) async throws -> Bool
}

struct ApiLoginGateway: LoginGateway {
    func loginUser(requestModel: LoginRequest) async throws -> Bool {
        return true
    }
}
