//
//  OMDB.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

enum OMDB {
    static let cache = Cache<Film>()
}

extension OMDB {
    static func load(_ service: Service,
                     _ completion: @escaping ((Result<Film, Networking.Error>) -> Void)) -> URLSessionDataTask? {
        
        let request = service.request()
        
        if let key = request.url?.absoluteString, let cachedFilm = cache.object(forKey: key) {
            completion(.success(cachedFilm))
            return nil
        } else {
            return Networking.object(request, Film.self, .snakeCase) { result in
                switch result {
                case .success(let film):
                    if let key = request.url?.absoluteString {
                        cache.insert(film, forKey: key)
                    }
                    
                    completion(.success(film))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
