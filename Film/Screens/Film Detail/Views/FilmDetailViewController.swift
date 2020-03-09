//
//  FilmDetailViewController.swift
//  Film
//
//  Created by Christian Ampe on 3/7/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit
import MapKit

final class FilmDetailViewController: UIViewController {
    
    init(nflxFilm: NFLX.Film, omdbFilm: OMDB.Film) {
        super.init(nibName: nil, bundle: nil)
        initialize(filmLocation: nflxFilm.locations, imageURL: omdbFilm.poster)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize(filmLocation: "", imageURL: "")
    }
    
    private var scrollView: UIScrollView!
    private var containerView: UIView!
    private var mapView: MKMapView!
    private var tileView: FilmDetailTileView!
    private var ratingLabel: UILabel!
    private var genreLabel: UILabel!
    private var plotLabel: UILabel!
    private var ctaButton: UIButton!
}

private extension FilmDetailViewController {
    func initialize(filmLocation location: String, imageURL: String) {
        scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        tileView = FilmDetailTileView()
        tileView.configure(withFilmLocation: location, imageURL: imageURL)
        tileView.clipsToBounds = true
        tileView.layer.cornerRadius = 5
        tileView.translatesAutoresizingMaskIntoConstraints = false
        
        ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        genreLabel = UILabel()
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        plotLabel = UILabel()
        plotLabel.translatesAutoresizingMaskIntoConstraints = false
        plotLabel.numberOfLines = 0
        plotLabel.text = "popopopopoppppopopopopopopopopopopo popopopopoppppopopopopopopopopopopo popopopopoppppopopopopopopopopopopo popopopopoppppopopopopopopopopopopo popopopopoppppopopopopopopopopopopo popopopopoppppopopopopopopopopopopo"
        
        ctaButton = UIButton(type: .system)
        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        ctaButton.clipsToBounds = true
        ctaButton.tintColor = .white
        ctaButton.setTitle("Get Directions", for: .normal)
        ctaButton.backgroundColor = .systemGreen
        ctaButton.layer.cornerRadius = 27
        
        let bottomConstraint = containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        bottomConstraint.priority = .defaultLow
        
        let centerYConstraint = containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        centerYConstraint.priority = .defaultLow
        
        scrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            bottomConstraint,
            centerYConstraint
        ])
        
        containerView.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        containerView.addSubview(tileView)
        NSLayoutConstraint.activate([
            tileView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            tileView.centerYAnchor.constraint(equalTo: mapView.bottomAnchor),
            tileView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
            tileView.heightAnchor.constraint(equalTo: tileView.widthAnchor)
        ])
        
        containerView.addSubview(plotLabel)
        NSLayoutConstraint.activate([
            plotLabel.topAnchor.constraint(equalTo: tileView.bottomAnchor, constant: 24),
            plotLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            plotLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        containerView.addSubview(ctaButton)
        NSLayoutConstraint.activate([
            ctaButton.topAnchor.constraint(equalTo: plotLabel.bottomAnchor, constant: 24),
            ctaButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            ctaButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            ctaButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            ctaButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
