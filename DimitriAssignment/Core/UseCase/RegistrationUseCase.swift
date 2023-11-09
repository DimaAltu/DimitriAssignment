//
//  RegistrationUseCase.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 09.11.23.
//

protocol RegistrationUseCase {
    func registerUser(requestModel: RegisterRequest) async throws -> Bool
}

struct RegistrationUseCaseImpl: RegistrationUseCase {
    
    let gateway: RegistrationGateway
    
    init(gateway: RegistrationGateway) {
        self.gateway = gateway
    }
    
    func registerUser(requestModel: RegisterRequest) async throws -> Bool {
        try await gateway.registerUser(requestModel: requestModel)
    }
}
