//
//  Networking.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation
import Combine

enum Networking {
    @discardableResult
    static func run<T: Decodable>(_ request: URLRequest,
                                  _ object: T.Type,
                                  _ decoder: JSONDecoder = .defaultCase) -> AnyPublisher<T, Error> {
        
        URLSession
            .shared
            .dataTaskPublisher(for: request)
            .tryMap { (try decoder.decode(T.self, from: $0.data)) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
