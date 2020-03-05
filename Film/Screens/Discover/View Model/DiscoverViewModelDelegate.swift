//
//  DiscoverViewModelDelegate.swift
//  Film
//
//  Created by Christian Ampe on 3/5/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

protocol DiscoverViewModelDelegate: class {
    func discoverViewModel(_ discoverViewModel: DiscoverViewModel, didUpdateCategories categories: [(String, [NFLX.Film])])
}
