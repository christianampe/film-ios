//
//  Service.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

protocol Service {
    @discardableResult
    static func run<T: Decodable>(_ request: URLRequest,
                                  _ object: T.Type,
                                  _ decoder: JSONDecoder) -> AnyPublisher<(T?, Data, URLResponse), Error>
}
