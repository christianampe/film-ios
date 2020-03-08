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
        
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        tileView = FilmDetailTileView()
        tileView.configure(withFilmLocation: location, imageURL: imageURL)
        tileView.translatesAutoresizingMaskIntoConstraints = false
        
        ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        genreLabel = UILabel()
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        plotLabel = UILabel()
        plotLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ctaButton = UIButton(type: .system)
        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.3)
        ])
        
        scrollView.addSubview(tileView)
        NSLayoutConstraint.activate([
            tileView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tileView.centerYAnchor.constraint(equalTo: mapView.bottomAnchor),
            tileView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            tileView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.3)
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
