//
//  IMGError.swift
//  Film
//
//  Created by Christian Ampe on 3/4/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

extension IMG {
    enum Error: Swift.Error {
        case inconsistency
        case invalidURL
        case invalidData
        case networking(Networking.Error)
    }
}
