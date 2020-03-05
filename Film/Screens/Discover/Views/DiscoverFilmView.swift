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
        imageView.image = UIImage(named: "nflx.logo")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        style()
        imageView.image = UIImage(named: "nflx.logo")
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
        viewModel = .init(film: film)
    }
}

// MARK: - Lifecycle
extension DiscoverFilmView {
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
}

// MARK: - Style Methods
private extension DiscoverFilmView {
    func style() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
}
