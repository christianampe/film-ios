//
//  NFLXService.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

extension NFLX {
    enum Service {
        case movies
    }
}

extension NFLX.Service: Target {
    var baseURL: URL {
        URL(string: "http://assets.nflxext.com")!
    }
    
    var paths: [String] {
        ["ffe/siteui/iosui/filmData.json"]
    }
}
