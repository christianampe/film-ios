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
                           didUpdateTheatres theatres: [(String, [NFLX.Film])]) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            var snapshot = NSDiffableDataSourceSnapshot<String, NFLX.Film>()
            var shouldAnimateDifferences = true
            
            if theatres.isEmpty {
                shouldAnimateDifferences = false
            }
            
            theatres.forEach { theatre in
                snapshot.appendSections([theatre.0])
                snapshot.appendItems(theatre.1, toSection: theatre.0)
            }
            
            self.collectionViewDataSource.apply(snapshot,
                                                animatingDifferences: shouldAnimateDifferences)
        }
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
        item.contentInsets = .init(top: 12, leading: 8, bottom: 12, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(148), heightDimension: .absolute(224))
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
        view.backgroundColor = .systemBackground
        
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
