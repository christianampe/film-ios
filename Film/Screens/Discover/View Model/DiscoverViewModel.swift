//
//  DiscoverViewModel.swift
//  Movies
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

final class DiscoverViewModel: ObservableObject {
    private let cache = Cache<[(String, [NFLX.Film])]>()
    private var films: [NFLX.Film]
    private var query: String
    private var movieTask: URLSessionDataTask?
    private lazy var debouncer = Debouncer(delay: 0.5)
    
    weak var delegate: DiscoverViewModelDelegate?
    
    init(films: [NFLX.Film] = [],
         query: String = "") {
        
        self.films = films
        self.query = query
    }
    
    deinit {
        movieTask?.cancel()
        movieTask = nil
    }
}

extension DiscoverViewModel {
    func fetch() {
        movieTask = NFLX.load(.movies) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let films):
                self.films = films
                self.analyze()
            case .failure:
                break
            }
        }
    }
    
    func filter(_ query: String) {
        self.query = query
        
        if let results = cache.object(forKey: query) {
            self.delegate?.discoverViewModel(self,
                                             didUpdateCategories: results)
        } else {
            debouncer.handler = analyze
            debouncer.call()
        }
    }
}

private extension DiscoverViewModel {
    func analyze() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            
            var results = [(String, [NFLX.Film])]()
            
            if self.query.isEmpty {
                results = self.group(self.films)
            } else {
                let filteredFilms = self.filter(self.films, query: self.query)
                results = self.group(filteredFilms)
            }
            
            self.cache.insert(results,
                              forKey: self.query)
            
            self.delegate?.discoverViewModel(self,
                                             didUpdateCategories: results)
        }
    }
}

private extension DiscoverViewModel {
    func filter(_ films: [NFLX.Film], query: String) -> [NFLX.Film] {
        films.filter { $0.contains(substring: query) }
    }
    
    func group(_ films: [NFLX.Film]) -> [(String, [NFLX.Film])] {
        let tempDict = Dictionary(grouping: films, by: { $0.locations })
        let categories = tempDict.sorted { $0.key < $1.key }
        
        return categories
    }
}
