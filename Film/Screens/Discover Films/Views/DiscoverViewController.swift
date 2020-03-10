//
//  DiscoverViewController.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit
import MapKit

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
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        (cell as! DiscoverFilmCell).cancelLoading()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? DiscoverFilmCell,
            let nflxFilm = cell.viewModel?.nflxFilm
        else {
            return
        }
        
        present(FilmDetailViewController(nflxFilm: nflxFilm,
                                         omdbFilm: cell.viewModel?.omdbFilm),
                animated: true)
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
        Location.shared.start()
        
        view.backgroundColor = .systemBackground
        
        searchBar = UISearchBar()
        searchBar.tintColor = .systemGray3
        searchBar.placeholder = "Title, actor, director, etc..."
        searchBar.delegate = self
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(148), heightDimension: .absolute(224))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 24
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .interactive
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerCollectionViewCell(DiscoverFilmCell.self)
        collectionView.registerReusableHeaderView(DiscoverFilmHeader.self)
        
        collectionViewDataSource = .init(collectionView: collectionView) { (collectionView, indexPath, film) in
            let cell = collectionView.dequeueReusableCell(for: indexPath) as DiscoverFilmCell
            cell.configure(withFilm: film)
            cell.load()
            return cell
        }
        
        collectionViewDataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let dataSource = collectionView.dataSource as? UICollectionViewDiffableDataSource<String, NFLX.Film> else {
                return nil
            }
            
            guard let film = dataSource.itemIdentifier(for: indexPath) else {
                return nil
            }
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as DiscoverFilmHeader
            header.configure(withFilm: film)
            return header
        }
        
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        viewModel.delegate = self
        viewModel.fetch()
    }
}
