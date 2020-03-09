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
    private var titleContainerView: UIView!
    private var titleLabel: UILabel!
    
    private(set) var viewModel: DiscoverFilmViewModel?
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
            case .failure:
                self?.imageView.image = UIImage(named: "nflx.icon")
            }
            
            self?.titleLabel.text = self?.viewModel?.nflxFilm?.title
        }
    }
}

private extension DiscoverFilmCell {
    func initialize() {
        layer.masksToBounds = true
        layer.cornerRadius = 6
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        titleContainerView = UIView()
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleContainerView.backgroundColor = .systemBackground
        titleContainerView.alpha = 0.95
        
        titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 10)
        
        contentView.addSubview(imageView)
        imageView.addSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -4),
        ])
    }
}
