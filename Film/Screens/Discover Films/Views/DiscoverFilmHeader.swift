//
//  DiscoverFilmHeader.swift
//  Film
//
//  Created by Christian Ampe on 3/7/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

final class DiscoverFilmHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private var titleLabel: UILabel!
    private var distanceLabel: UILabel!
    
    private(set) var film: NFLX.Film?
}

extension DiscoverFilmHeader {
    func configure(withFilm film: NFLX.Film) {
        self.film = film
        titleLabel.text = film.locations
        
        if let location = Location.shared.current {
            let meterDistance = location.distance(from: .init(latitude: film.latitude, longitude: film.longitude))
            let mileDistance = meterDistance / 1609.34
            distanceLabel.text = "📍\(String(format: "%.1f", mileDistance)) mi"
        }
    }
}

private extension DiscoverFilmHeader {
    func initialize() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        distanceLabel = UILabel()
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.textColor = .secondaryLabel
        distanceLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        addSubview(titleLabel)
        addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            distanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
