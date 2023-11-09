//
//  RegistrationRouter.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 07.11.23.
//

import UIKit

protocol RegistrationRouter {
    func openDashboardPage()
}

class RegistrationRouterImpl: RegistrationRouter {
    
    weak var controller: UIViewController?
    
    init(controller: UIViewController?) {
        self.controller = controller
    }
    
    func openDashboardPage() {
        let vc = HomeController()
        let router = HomeRouterImpl(view: vc)
        let viewModel = HomeViewModel(imagesRepository: WebImagesRepository(), router: router)
        vc.viewModel = viewModel
        controller?.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
