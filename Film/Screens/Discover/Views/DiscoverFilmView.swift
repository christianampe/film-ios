//
//  DiscoverFilmCell.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

final class DiscoverFilmView: UICollectionViewCell {
    
    private var viewModel: DiscoverFilmViewModel = .init(film: .empty)
    
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
    
    private lazy var label: UILabel = {
        let label = UILabel()
        imageView.addSubview(label)
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.textColor = .red
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
}

extension DiscoverFilmView {
    func configure(withFilm film: NFLX.Film) {
        label.text = film.title
        viewModel = .init(film: film)
        viewModel.delegate = self
        viewModel.load()
    }
}

// MARK: - Lifecycle
extension DiscoverFilmView {
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel.stopLoading()
        imageView.image = nil
    }
}

// MARK: - Style Methods
private extension DiscoverFilmView {
    func style() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
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
