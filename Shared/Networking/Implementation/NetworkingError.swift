//
//  NetworkingError.swift
//  Film
//
//  Created by Christian Ampe on 3/6/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

extension Networking {
    enum Error: Swift.Error {
        case inconsistency
        case underlying(Swift.Error)
        case parsing
    }
}
