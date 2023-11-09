//
//  LoginRouter.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 07.11.23.
//

import UIKit

protocol LoginRouter {
    func openRegisterController()
    func openDashboard()
}

class LoginRouterImpl: LoginRouter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func openRegisterController() {
        let vc = RegistrationController()
        let router = RegistrationRouterImpl(controller: vc)
        let viewModel = RegistrationViewModel(
            email: "",
            password: "",
            age: nil,
            router: router,
            emailValidator: EmailValidatorImpl(),
            passwordValidator: PasswordValidatorImpl(),
            ageValidator: AgeValidatorImpl(),
            registerUseCase: RegistrationUseCaseImpl(gateway: ApiRegistrationGateway())
        )
        vc.viewModel = viewModel
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDashboard() {
        let vc = HomeController()
        let router = HomeRouterImpl(view: vc)
        let viewModel = HomeViewModel(imagesRepository: WebImagesRepository(), router: router)
        vc.viewModel = viewModel
        
        viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
}
