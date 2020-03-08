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
    func configure(withFilmLocation location: String, imageURL: String) {
        locationLabel.text = location
        
        IMG.load(atURL: imageURL) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let image):
                self.albumArt.image = image
            case .failure:
                break
            }
        }
    }
}

private extension FilmDetailTileView {
    func initialize() {
        locationLabel = UILabel()
        locationLabel.textAlignment = .center
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        albumArt = UIImageView()
        albumArt.contentMode = .scaleAspectFill
        
        addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(albumArt)
        albumArt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumArt.topAnchor.constraint(equalTo: locationLabel.topAnchor),
            albumArt.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumArt.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
