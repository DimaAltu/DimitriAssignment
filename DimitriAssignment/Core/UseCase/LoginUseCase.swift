//
//  LoginUseCase.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 09.11.23.
//

protocol LoginUseCase {
    func loginUser(requestModel: LoginRequest) async throws -> Bool
}

struct LoginUseCaseImpl: LoginUseCase {
    
    let gateway: LoginGateway
    
    init(gateway: LoginGateway) {
        self.gateway = gateway
    }
    
    func loginUser(requestModel: LoginRequest) async throws -> Bool {
        try await gateway.loginUser(requestModel: requestModel)
    }
}
