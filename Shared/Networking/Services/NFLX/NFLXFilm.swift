//
//  NFLXFilm.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

extension NFLX {
    struct Film: Decodable {
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

extension NFLX.Film: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension NFLX.Film {
    func contains(substring: String) -> Bool {
        var comparisonString = actors.joined()
        comparisonString += director
        comparisonString += locations
        comparisonString += releaseYear
        comparisonString += title
        
        if let writers = writers {
            comparisonString += writers.joined()
        }
        
        return comparisonString.lowercased().contains(substring.lowercased())
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
