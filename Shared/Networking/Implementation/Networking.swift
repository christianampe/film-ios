//
//  Networking.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

enum Networking {
    @discardableResult
    static func data(_ request: URLRequest,
                     _ completion: @escaping ((Result<Data, Error>) -> Void)) -> URLSessionDataTask {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.underlying(error)))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.inconsistency))
            }
        }
        
        task.resume()
        
        return task
    }
    
    @discardableResult
    static func object<T: Decodable>(_ request: URLRequest,
                                     _ object: T.Type,
                                     _ decoder: JSONDecoder = .defaultCase,
                                     _ completion: @escaping ((Result<T, Error>) -> Void)) -> URLSessionDataTask {
        
        return data(request) { result in
            switch result {
            case .success(let data):
                guard let object = try? decoder.decode(T.self, from: data) else {
                    completion(.failure(.parsing))
                    return
                }
                
                completion(.success(object))
                
            case .failure(let error):
                completion(.failure(.underlying(error)))
            }
        }
    }
}
