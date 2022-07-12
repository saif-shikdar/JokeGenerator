//
//  JokeService.swift
//  JokeApp
//
//  Created by Saif Shikdar on 12/07/2022.
//

import Foundation
import Combine

enum ServiceError: Error {
    case errorWith(message: String)
}

protocol JokeService {
    func get(urlRequest: URLRequest) -> AnyPublisher<Data, ServiceError>
}

class JokeServiceImp: JokeService {
    func get(urlRequest: URLRequest) -> AnyPublisher<Data, ServiceError> {
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { response -> Data in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw ServiceError.errorWith(message: "Something went wrong")
                }
                
                return response.data
            }
            .mapError { _ in ServiceError.errorWith(message: "Something went wrong")}
            .eraseToAnyPublisher()
    }
}
