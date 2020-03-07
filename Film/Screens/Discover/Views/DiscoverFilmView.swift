//
//  DiscoverFilmCell.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

final class DiscoverFilmView: UICollectionViewCell {
    private var viewModel: DiscoverFilmViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        style()
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}

extension DiscoverFilmView {
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
extension DiscoverFilmView {
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

extension DiscoverFilmView: DiscoverFilmViewModelDelegate {
    func discoverFilmViewModel(_ discoverFilmViewModel: DiscoverFilmViewModel,
                               didRetrieveOMDBPoster result: Result<UIImage, IMG.Error>) {
        
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure:
                self?.imageView.image = UIImage(named: "nflx.icon")
            }
        }
    }
}

private extension DiscoverFilmView {
    func style() {
        layer.masksToBounds = true
        layer.cornerRadius = 6
    }
}
