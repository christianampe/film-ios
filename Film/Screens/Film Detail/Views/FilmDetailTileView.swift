//
//  FilmDetailTileView.swift
//  Film
//
//  Created by Christian Ampe on 3/7/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

final class FilmDetailTileView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private var locationLabel: UILabel!
    private var albumArt: UIImageView!
}

extension FilmDetailTileView {
    func configure(withFilmLocation location: String, imageURL: String?) {
        locationLabel.text = "📍 \(location)"
        
        if let imageURL = imageURL {
            IMG.load(atURL: imageURL) { [weak self] result in
                guard let self = self else {
                    return
                }

                switch result {
                case .success(let image):
                    self.albumArt.image = image
                case .failure:
                    self.albumArt.image = UIImage(named: "nflx.icon")
                }
            }
        } else {
            self.albumArt.image = UIImage(named: "nflx.icon")
        }
    }
}

private extension FilmDetailTileView {
    func initialize() {
        backgroundColor = .systemBackground
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textAlignment = .center
        locationLabel.adjustsFontSizeToFitWidth = true
        locationLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        albumArt = UIImageView()
        albumArt.translatesAutoresizingMaskIntoConstraints = false
        albumArt.contentMode = .scaleAspectFill
        
        addSubview(locationLabel)
        addSubview(albumArt)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            albumArt.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4),
            albumArt.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumArt.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
