//
//  HomeViewModel.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 07.11.23.
//

import Foundation

class HomeViewModel {
    
    var rows: GenericBox<[AppCellViewModel]>
    var imageList: [ImageModel]? {
        didSet {
            DispatchQueue.main.async {
                self.configureRows(imageList: self.imageList ?? [])
            }
        }
    }
    
    let imagesRepository: ImagesRepository
    let router: HomeRouter
    
    init(imagesRepository: ImagesRepository,
         router: HomeRouter) {
        self.rows = GenericBox([])
        self.imagesRepository = imagesRepository
        self.router = router
        getImages()
    }
    
    private func configureRows(imageList: [ImageModel]) {
        var rowItems: [AppCellViewModel] = []
        let viewModels = imageList.map { HomeImageCellViewModel(imageUrl: URL(string: $0.webformatURL), title: $0.user) }
        rowItems.append(contentsOf: viewModels)
        rows.value = rowItems
    }
    
    private func getImages() {
        Task.init {
            do {
                self.imageList = try await imagesRepository.getImages()
            } catch {
                print("Fetching establishments failed with error \(error)")
            }
        }
    }
    
    func navigateToDetailsPage(modelIndex: Int) {
        if let model = imageList?[modelIndex] {
            router.navigateToDetailPage(model: model)
        }
    }
}
