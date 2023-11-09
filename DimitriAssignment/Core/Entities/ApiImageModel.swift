//
//  ApiImageModel.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 08.11.23.
//

import Foundation

struct ApiImageResult: Codable {
    let total: Int?
    let totalHits: Int?
    let hits: [ApiImageModel]
}

struct ApiImageModel: Codable {
    let webformatURL: String
    let imageSize: Int
    let type: String
    let tags: String
    let user: String
    let downloads: Int
    let likes: Int
    let comments: Int
    let views: Int
    let collections: Int
    
    var toModel: ImageModel {
        ImageModel(
            webformatURL: webformatURL,
            imageSize: imageSize,
            type: type,
            tags: tags,
            user: user,
            downloads: downloads,
            likes: likes,
            comments: comments,
            views: views,
            collections: collections
        )
    }
}
