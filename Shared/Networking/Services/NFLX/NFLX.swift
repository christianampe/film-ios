//
//  NFLX.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

enum NFLX {
    static let cache = Cache<[Film]>()
}

extension NFLX {
    static func load(_ service: Service,
                     _ completion: @escaping ((Result<[Film], Networking.Error>) -> Void)) -> URLSessionDataTask? {
        
        let request = service.request()
        let key = request.url!.absoluteString
        
        if let cachedFilms = cache.object(forKey: key) {
            completion(.success(cachedFilms))
            return nil
        } else {
            return Networking.object(request, [Film].self, .snakeCase) { result in
                switch result {
                case .success(let films):
                    cache.insert(films, forKey: key)
                    completion(.success(films))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
