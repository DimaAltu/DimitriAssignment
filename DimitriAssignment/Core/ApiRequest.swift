//
//  ApiRequest.swift
//  DimitriAssignment
//
//  Created by Dimitri Altunashvili on 08.11.23.
//

import Foundation

class ApiRequest {
    
    enum APIRouter {
        case getImages
        case register
        case login
        
        var url: URL? {
            switch self {
            case .getImages:
                URL(string: "https://pixabay.com/api/?key=40538321-51cdd30589b6b198300a8f010&image_type=photo&pretty=true")
            case .register:
                URL(string: "register")
            case .login:
                URL(string: "login")
            }
        }
        
        var method: String {
            switch self {
            case .getImages:
                return "GET"
            case .login, .register:
                return "POST"
            }
        }
    }
    
    enum APIRequestError: Error {
        case badUrl, noData
    }
    
    class func request<T: Codable>(apiRouter: APIRouter) async throws -> T {
        
        guard let url = apiRouter.url else { throw APIRequestError.badUrl }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRouter.method
        let session = URLSession(configuration: .default)
        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    return continuation.resume(with: .failure(error))
                }

                guard let data = data else {
                    return continuation.resume(with: .failure(APIRequestError.noData))
                }

                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        return continuation.resume(with: .success(responseObject))
                    }
                } catch {
                    return continuation.resume(with: .failure(error))
                }
            }
            dataTask.resume()
        }
    }
}
