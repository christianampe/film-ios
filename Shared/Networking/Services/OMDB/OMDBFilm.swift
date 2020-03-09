//
//  OMDBFilm.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

extension OMDB {
    struct Film: Decodable {
        let rated: String
        let runtime: String
        let genre: String
        let plot: String
        let awards: String
        let poster: String
        let imdbRating: String
        let imdbVotes: String
    }
}

extension OMDB.Film {
    enum CodingKeys: String, CodingKey {
        case rated  = "Rated"
        case runtime = "Runtime"
        case genre = "Genre"
        case plot = "Plot"
        case awards = "Awards"
        case poster = "Poster"
        case imdbRating
        case imdbVotes
    }
}

extension OMDB.Film {
    static let empty = OMDB.Film(rated: "",
                                 runtime: "",
                                 genre: "",
                                 plot: "",
                                 awards: "",
                                 poster: "",
                                 imdbRating: "",
                                 imdbVotes: "")
}
