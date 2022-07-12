//
//  Repository.swift
//  JokeApp
//
//  Created by Saif Shikdar on 12/07/2022.
//

import Foundation
import Combine

protocol RepositoryService {
    func fetchJoke<T:Decodable>(modelType:T.Type) -> AnyPublisher<T, ServiceError>
}

class Repository: RepositoryService {
    
    let service: JokeService
    
    init(jokeService: JokeService = JokeServiceImp()) {
        self.service = jokeService
    }
    
    func fetchJoke<T:Decodable>(modelType:T.Type) -> AnyPublisher<T, ServiceError> {
        guard let request = URLRequest.getRequest(url: Endpoint.url, path: "") else {
            return Fail(error: ServiceError.errorWith(message: "Something went wrong")).eraseToAnyPublisher()
        }
        
        return service.get(urlRequest: request)
            .decode(type: T.self, decoder: JSONDecoder())
            .tryMap { result in
                return result
            }.mapError { _ in
                ServiceError.errorWith(message: "Something went wrong")
            }
            .eraseToAnyPublisher()
    }
}

extension URLRequest {
    static func getRequest(url: String, path: String) -> Self? {
        guard var urlComponents = URLComponents(string: url.appending(path)) else {
            return nil
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "api-key", value: Endpoint.key)]
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}

