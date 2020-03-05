//
//  DiscoverViewModel.swift
//  Movies
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

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
        movieTask?.cancel()
        movieTask = nil
    }
    
    weak var delegate: DiscoverViewModelDelegate?
    
    private var movieTask: URLSessionDataTask?
    
    private(set) var categories: [(String, [NFLX.Film])] = [] {
        didSet {
            delegate?.discoverViewModel(self, didUpdateCategories: categories)
        }
    }
}

extension DiscoverViewModel {
    func fetch() {
        movieTask = Networking.object(NFLX.Service.movies.request(), [NFLX.Film].self, .snakeCase) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let films):
                self.films = films
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

private extension DiscoverViewModel {
    func analyze() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                return
            }
            
            let tempDict = Dictionary(grouping: self.films, by: { $0.locations })
            let categories = tempDict.sorted { $0.key < $1.key }
            
            self.categories = categories
        }
    }
}
