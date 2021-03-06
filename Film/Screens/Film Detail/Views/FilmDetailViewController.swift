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
    private let nflxFilm: NFLX.Film
    private let omdbFilm: OMDB.Film?
    
    init(nflxFilm: NFLX.Film, omdbFilm: OMDB.Film?) {
        self.nflxFilm = nflxFilm
        self.omdbFilm = omdbFilm
        
        super.init(nibName: nil, bundle: nil)
        
        initialize(nflxFilm: nflxFilm, omdbFilm: omdbFilm)
    }
    
    required init?(coder: NSCoder) {
        self.nflxFilm = .empty
        self.omdbFilm = .empty
        
        super.init(coder: coder)
        
        initialize(nflxFilm: .empty, omdbFilm: .empty)
    }
    
    private lazy var scrollView = UIScrollView()
    private lazy var containerView = UIView()
    private lazy var mapView = MKMapView()
    private lazy var tileView = FilmDetailTileView()
    private lazy var scoreLabel = UILabel()
    private lazy var releasedLabel = UILabel()
    private lazy var releaseYearLabel = UILabel()
    private lazy var titleLabel = UILabel()
    private lazy var ratingLabel = UILabel()
    private lazy var runtimeLabel = UILabel()
    private lazy var durationLabel = UILabel()
    private lazy var plotLabel = UILabel()
    private lazy var ctaButton = UIButton(type: .system)
}

private extension FilmDetailViewController {
    func initialize(nflxFilm: NFLX.Film, omdbFilm: OMDB.Film?) {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .systemBackground
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isUserInteractionEnabled = false
        let location = CLLocationCoordinate2D(latitude: nflxFilm.latitude, longitude: nflxFilm.longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: false)
        
        tileView.translatesAutoresizingMaskIntoConstraints = false
        tileView.configure(withFilmLocation: nflxFilm.locations, imageURL: omdbFilm?.poster)
        tileView.clipsToBounds = true
        tileView.layer.cornerRadius = 5
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.clipsToBounds = true
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = .systemBackground
        scoreLabel.font = .systemFont(ofSize: 14, weight: .bold)
        scoreLabel.backgroundColor = .label
        scoreLabel.layer.borderColor = UIColor.systemGreen.cgColor
        scoreLabel.layer.borderWidth = 1
        scoreLabel.layer.cornerRadius = 18
        scoreLabel.text = "\(omdbFilm?.imdbRating ?? "-") / 10"
        
        releasedLabel.translatesAutoresizingMaskIntoConstraints = false
        releasedLabel.font = .systemFont(ofSize: 16, weight: .bold)
        releasedLabel.text = "Released"
        
        releaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseYearLabel.font = .systemFont(ofSize: 16, weight: .medium)
        releaseYearLabel.text = nflxFilm.releaseYear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.text = "\"\(nflxFilm.title)\""
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = .systemFont(ofSize: 18, weight: .bold)
        ratingLabel.textAlignment = .center
        ratingLabel.text = omdbFilm?.rated ?? "N/A"
        
        runtimeLabel.translatesAutoresizingMaskIntoConstraints = false
        runtimeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        runtimeLabel.textAlignment = .left
        runtimeLabel.text = "Runtime"
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.font = .systemFont(ofSize: 16, weight: .medium)
        durationLabel.textAlignment = .left
        durationLabel.text = omdbFilm?.runtime ?? "N/A"
        
        plotLabel.translatesAutoresizingMaskIntoConstraints = false
        plotLabel.font = .systemFont(ofSize: 14, weight: .medium)
        plotLabel.numberOfLines = 0
        plotLabel.text = "Plot\n\(omdbFilm?.plot ?? "N/A")"

        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        ctaButton.clipsToBounds = true
        ctaButton.tintColor = .systemBackground
        ctaButton.setTitle("Get Directions", for: .normal)
        ctaButton.backgroundColor = .systemGreen
        ctaButton.layer.cornerRadius = 27
        ctaButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        ctaButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ctaButtonTapped)))
        
        scrollView.addSubview(containerView)
        containerView.addSubview(mapView)
        containerView.addSubview(tileView)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(releasedLabel)
        containerView.addSubview(releaseYearLabel)
        containerView.addSubview(runtimeLabel)
        containerView.addSubview(durationLabel)
        containerView.addSubview(plotLabel)
        containerView.addSubview(ctaButton)
        view.addSubview(scrollView)
        
        let bottomConstraint = containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        bottomConstraint.priority = .defaultLow
        
        let centerYConstraint = containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        centerYConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            bottomConstraint,
            centerYConstraint,
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mapView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 240),
            tileView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            tileView.centerYAnchor.constraint(equalTo: mapView.bottomAnchor),
            tileView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7),
            tileView.heightAnchor.constraint(equalTo: tileView.widthAnchor),
            scoreLabel.centerXAnchor.constraint(equalTo: tileView.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: tileView.bottomAnchor),
            scoreLabel.widthAnchor.constraint(equalTo: tileView.widthAnchor, multiplier: 0.4),
            scoreLabel.heightAnchor.constraint(equalToConstant: 36),
            titleLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            ratingLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            releasedLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 12),
            releasedLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            releaseYearLabel.topAnchor.constraint(equalTo: releasedLabel.bottomAnchor),
            releaseYearLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            runtimeLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 12),
            runtimeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            durationLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            plotLabel.topAnchor.constraint(equalTo: releaseYearLabel.bottomAnchor, constant: 24),
            plotLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            plotLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            ctaButton.topAnchor.constraint(equalTo: plotLabel.bottomAnchor, constant: 24),
            ctaButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            ctaButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            ctaButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            ctaButton.heightAnchor.constraint(equalToConstant: 54),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

private extension FilmDetailViewController {
    @objc func ctaButtonTapped(_ sender: UIButton) {
        let coordinate = CLLocationCoordinate2D(latitude: nflxFilm.latitude, longitude: nflxFilm.longitude)
        let mapItem = MKMapItem(placemark: .init(coordinate: coordinate))
        mapItem.name = nflxFilm.locations
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
}
