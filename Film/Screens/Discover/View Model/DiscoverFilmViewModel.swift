//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation
import Combine

final class DiscoverFilmViewModel: ObservableObject {
    let film: NFLX.Film
    
    init(film: NFLX.Film) {
        self.film = film
    }
    
    deinit {
        stop()
    }

    private var cancellable: AnyCancellable?

    @Published private(set) var imageData: Data?
}

extension DiscoverFilmViewModel {
    func load() {

    }

    func stop() {
        cancellable?.cancel()
        cancellable = nil
    }
}
