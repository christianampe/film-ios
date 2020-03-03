//
//  DiscoverRowView.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

final class DiscoverRowView: UITableViewCell {
    
    var viewModel: DiscoverRowViewModel = .init(title: "", films: [])
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.registerCollectionViewCell(DiscoverFilmView.self)
        return collectionView
    }()
    
}

// MARK: - External API
extension DiscoverRowView {
    func configure(title: String, films: [NFLX.Film]) {
        viewModel = .init(title: title, films: films)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension DiscoverRowView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        viewModel.films.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        collectionView.dequeueReusableCell(for: indexPath) as DiscoverFilmView
    }
}

extension DiscoverRowView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let cell = cell as! DiscoverFilmView
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let cell = cell as! DiscoverFilmView
        
    }
}
