//
//  DiscoverRowViewModel.swift
//  Movies
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

final class DiscoverRowViewModel {
    let title: String
    let films: [NFLX.Film]
    
    init(title: String,
         films: [NFLX.Film]) {
        
        self.title = title
        self.films = films
    }
}
