//
//  NFLXFilm.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

extension NFLX {
    struct Film: Decodable, Identifiable {
        let id = UUID()
        
        let actors: [String]
        let director: String
        let funFacts: String?
        let latitude: Double
        let locations: String
        let longitude: Double
        let productionCompany: String
        let releaseYear: String
        let title: String
        let writers: [String]?
    }
}

extension NFLX.Film: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.title == rhs.title && lhs.productionCompany == rhs.productionCompany && lhs.releaseYear == rhs.releaseYear)
        
    }
}

extension NFLX.Film {
    static let empty = NFLX.Film(actors: [],
                                  director: "",
                                  funFacts: nil,
                                  latitude: 0,
                                  locations: "",
                                  longitude: 0,
                                  productionCompany: "",
                                  releaseYear: "",
                                  title: "",
                                  writers: nil)
}
