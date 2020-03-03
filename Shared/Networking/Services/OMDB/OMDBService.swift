//
//  OMDBService.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

extension OMDB {
    enum Service {
        case movies(query: String)
    }
}

extension OMDB.Service: Target {
    var baseURL: URL {
        URL(string: "http://www.omdbapi.com")!
    }
    
    var parameters: [String : String] {
        switch self {
        case .movies(let query):
            return ["apikey": "6ff8ac9e",
                    "t": query]
        }
    }
}
