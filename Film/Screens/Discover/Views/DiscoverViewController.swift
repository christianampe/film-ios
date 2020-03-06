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
        title = "Films"
        viewModel.delegate = self
        viewModel.fetch()
        searchBar.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        viewModel = .init()
        super.init(coder: coder)
        title = "Films"
        viewModel.delegate = self
        viewModel.fetch()
        searchBar.layoutIfNeeded()
    }
    
    private lazy var searchBarContainerView: UIView = {
        let searchBarContainerView = UIView()
        view.addSubview(searchBarContainerView)
        searchBarContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchBarContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBarContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return searchBarContainerView
    }()
    
    private lazy var searchBar: DiscoverSearchBar = {
        let searchBar = DiscoverSearchBar()
        searchBarContainerView.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.heightAnchor.constraint(equalToConstant: 56).isActive = true
        searchBar.topAnchor.constraint(equalTo: searchBarContainerView.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: searchBarContainerView.leadingAnchor, constant: 28).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: searchBarContainerView.trailingAnchor, constant: 28).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: searchBarContainerView.bottomAnchor).isActive = true
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: searchBarContainerView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.registerCollectionViewCell(DiscoverFilmView.self)
        collectionView.delegate = self
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.48),
                                               heightDimension: .fractionalHeight(0.36))
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
        
        categories.forEach { category in
            snapshot.appendSections([category.0])
            snapshot.appendItems(category.1, toSection: category.0)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionViewDataSource.apply(snapshot,
                                                 animatingDifferences: true)
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
