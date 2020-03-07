//
//  IMG.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

enum IMG {
    private static var cache = Cache<UIImage>()
}

extension IMG {
    static func load(atURL imageURL: String,
                     _ completion: @escaping ((Result<UIImage, Error>) -> Void)) -> URLSessionDataTask? {
        
        if let image = cache.object(forKey: imageURL) {
            completion(.success(image))
            return nil
        } else {
            guard let url = URL(string: imageURL) else {
                completion(.failure(.invalidURL))
                return nil
            }
            
            return Networking.data(.init(url: url)) { result in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completion(.failure(.invalidData))
                        return
                    }
                    
                    cache.insert(image, forKey: imageURL)
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(.networking(error)))
                }
            }
        }
    }
}
