//
//  DiscoverFilmCell.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

final class DiscoverFilmCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private var imageView: UIImageView!
    
    private var viewModel: DiscoverFilmViewModel?
}

extension DiscoverFilmCell {
    func configure(withFilm film: NFLX.Film) {
        viewModel = .init()
        viewModel?.delegate = self
        viewModel?.configure(film)
    }
    
    func load() {
        viewModel?.load()
    }
    
    func cancelLoading() {
        viewModel?.cancelLoading()
    }
}

// MARK: - Lifecycle
extension DiscoverFilmCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

extension DiscoverFilmCell: DiscoverFilmViewModelDelegate {
    func discoverFilmViewModel(_ discoverFilmViewModel: DiscoverFilmViewModel,
                               didRetrieveOMDBPoster result: Result<UIImage, IMG.Error>) {
        
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(let error):
                print(error)
                self?.imageView.image = UIImage(named: "nflx.icon")
            }
        }
    }
}

private extension DiscoverFilmCell {
    func initialize() {
        layer.masksToBounds = true
        layer.cornerRadius = 6
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
