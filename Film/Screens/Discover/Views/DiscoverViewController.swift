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
    }
    
    required init?(coder: NSCoder) {
        viewModel = .init()
        super.init(coder: coder)
    }
    
    private var searchBar: UISearchBar!
    private var collectionView: UICollectionView!
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<String, NFLX.Film>!
}

extension DiscoverViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
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
        
        self.collectionViewDataSource.apply(snapshot,
                                            animatingDifferences: shouldAnimateDifferences)
    }
}

extension DiscoverViewController: UICollectionViewDelegate {
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

private extension DiscoverViewController {
    func initialize() {
        searchBar = UISearchBar()
        searchBar.tintColor = .systemGray3
        searchBar.placeholder = "Title, actor, director, ect..."
        searchBar.delegate = self
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.36), heightDimension: .fractionalHeight(0.24))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .interactive
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerCollectionViewCell(DiscoverFilmView.self)
        
        collectionViewDataSource = .init(collectionView: collectionView) { (collectionView, indexPath, film) in
            let cell = collectionView.dequeueReusableCell(for: indexPath) as DiscoverFilmView
            cell.configure(withFilm: film)
            cell.load()
            return cell
        }
        
        navigationItem.titleView = searchBar
        view.backgroundColor = .systemGray6
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        viewModel.delegate = self
        viewModel.fetch()
    }
}
