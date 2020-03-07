//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

final class DiscoverFilmViewModel: ObservableObject {
    deinit {
        cancelLoading()
    }
    
    weak var delegate: DiscoverFilmViewModelDelegate?

    private(set) var nflxFilm: NFLX.Film?
    private(set) var omdbFilm: OMDB.Film?
    private(set) var imageData: Data?
    
    private var operation: URLSessionDataTask?
}

extension DiscoverFilmViewModel {
    func configure(_ film: NFLX.Film) {
        nflxFilm = film
    }
    
    func load() {
        guard let strippedFilmTitle = nflxFilm?.strippedTitle else {
            return
        }
        
        operation = OMDB.load(.movies(query: strippedFilmTitle)) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let film):
                self.operation = IMG.load(atURL: film.poster) { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    
                    self.delegate?.discoverFilmViewModel(self,
                                                         didRetrieveOMDBPoster: result)
                }
            case .failure(let error):
                self.delegate?.discoverFilmViewModel(self,
                                                     didRetrieveOMDBPoster: .failure(.networking(error)))
            }
        }
    }

    func cancelLoading() {
        operation?.cancel()
        operation = nil
    }
}
