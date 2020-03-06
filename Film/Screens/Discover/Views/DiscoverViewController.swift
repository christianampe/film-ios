//
//  DiscoverViewController.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

final class DiscoverViewController: UIViewController {
    private let viewModel: DiscoverViewModel
    
    init(viewModel: DiscoverViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        navigationItem.titleView = searchBarView
        view.backgroundColor = .systemGray6
        viewModel.delegate = self
        viewModel.fetch()
    }
    
    required init?(coder: NSCoder) {
        viewModel = .init()
        super.init(coder: coder)
        navigationItem.titleView = searchBarView
        view.backgroundColor = .systemGray6
        viewModel.delegate = self
        viewModel.fetch()
    }
    
    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.tintColor = .systemGray3
        searchBar.placeholder = "Title, actor, director, ect..."
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.registerCollectionViewCell(DiscoverFilmView.self)
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .interactive
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10,
                                   leading: 10,
                                   bottom: 10,
                                   trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.36),
                                               heightDimension: .fractionalHeight(0.24))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    private lazy var collectionViewDataSource: UICollectionViewDiffableDataSource<String, NFLX.Film> = {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, film) in
            let cell = collectionView.dequeueReusableCell(for: indexPath) as DiscoverFilmView
            cell.configure(withFilm: film)
            return cell
        }
    }()
}

extension DiscoverViewController: DiscoverViewModelDelegate {
    func discoverViewModel(_ discoverViewModel: DiscoverViewModel,
                           didUpdateCategories categories: [(String, [NFLX.Film])]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<String, NFLX.Film>()
        var shouldAnimateDifferences = true
        
        if categories.isEmpty {
            shouldAnimateDifferences = false
        }
        
        categories.forEach { category in
            snapshot.appendSections([category.0])
            snapshot.appendItems(category.1, toSection: category.0)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionViewDataSource.apply(snapshot,
                                                 animatingDifferences: shouldAnimateDifferences)
        }
    }
}

extension DiscoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        (cell as! DiscoverFilmView).load()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        (cell as! DiscoverFilmView).cancelLoading()
    }
}

extension DiscoverViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        
        viewModel.filter(searchText)
    }
}
