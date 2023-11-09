//
//  HomeRouter.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 07.11.23.
//

import UIKit

protocol HomeRouter {
    func navigateToDetailPage(model: ImageModel)
}

class HomeRouterImpl: HomeRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
    func navigateToDetailPage(model: ImageModel) {
        let viewModel = DetailsViewModel(imageModel: model)
        let vc = DetailsController(viewModel: viewModel)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
