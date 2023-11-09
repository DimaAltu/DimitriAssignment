//
//  ImagesRepository.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 09.11.23.
//

import Foundation

protocol ImagesRepository {
    func getImages() async throws -> [ImageModel]
}

struct WebImagesRepository: ImagesRepository {
    
    func getImages() async throws -> [ImageModel] {
        let response: ApiImageResult = try await ApiRequest.request(apiRouter: .getImages)
        return response.hits.map { $0.toModel }
    }
}
