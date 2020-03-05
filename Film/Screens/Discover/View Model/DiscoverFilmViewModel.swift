//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

final class DiscoverFilmViewModel: ObservableObject {
    private let film: NFLX.Film
    
    init(film: NFLX.Film) {
        self.film = film
    }
    
    deinit {
        stopLoading()
    }
    
    weak var delegate: DiscoverFilmViewModelDelegate?

    private(set) var omdbFilm: OMDB.Film?
    private(set) var imageData: Data?
    
    private var operation: URLSessionDataTask?
}

extension DiscoverFilmViewModel {
    func load() {
        operation = Networking.object(OMDB.Service.movies(query: film.strippedTitle).request(), OMDB.Film.self) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let film):
                self.operation = IMG.load(atURL: film.poster) { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    
                    self.delegate?.discoverFilmViewModel(self, didRetrieveOMDBPoster: result)
                }
            case .failure(let error):
                self.delegate?.discoverFilmViewModel(self, didRetrieveOMDBPoster: .failure(.networking(error)))
            }
        }
    }

    func stopLoading() {
        operation?.cancel()
        operation = nil
    }
}
