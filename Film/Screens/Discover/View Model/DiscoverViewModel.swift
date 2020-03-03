//
//  DiscoverViewModel.swift
//  Movies
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation
import Combine

final class DiscoverViewModel: ObservableObject {
    private var films: [NFLX.Film] {
        didSet {
            analyze()
        }
    }
    
    init(films: [NFLX.Film] = []) {
        self.films = films
    }
    
    deinit {
        cancellable?.cancel()
        cancellable = nil
    }
    
    private var cancellable: AnyCancellable?
    
    @Published private(set) var categories: [(String, [NFLX.Film])] = []
}

extension DiscoverViewModel {
    func load() {
        cancellable = Networking.run(NFLX.Service.movies.request(), [NFLX.Film].self, .snakeCase)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: \.films, on: self)
    }
}

private extension DiscoverViewModel {
    func analyze() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                return
            }
            
            let tempDict = Dictionary(grouping: self.films, by: { $0.releaseYear })
            let categories = tempDict.sorted { $0.key < $1.key }
            
            DispatchQueue.main.async {
                self.categories = categories
            }
        }
    }
}
