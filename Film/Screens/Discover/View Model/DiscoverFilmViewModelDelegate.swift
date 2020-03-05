//
//  DiscoverFilmViewModelDelegate.swift
//  Film
//
//  Created by Christian Ampe on 3/5/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit.UIImage

protocol DiscoverFilmViewModelDelegate: class {
    func discoverFilmViewModel(_ discoverFilmViewModel: DiscoverFilmViewModel, didRetrieveOMDBFilm film: OMDB.Film)
    func discoverFilmViewModel(_ discoverFilmViewModel: DiscoverFilmViewModel, didRetrieveOMDBPoster poster: UIImage)
}
