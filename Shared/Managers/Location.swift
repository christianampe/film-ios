//
//  Location.swift
//  Film
//
//  Created by Christian Ampe on 3/9/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import CoreLocation

final class Location {
    static let shared = Location()
    
    private lazy var manager = CLLocationManager()
    
    var current: CLLocation? {
        return manager.location
    }
}

extension Location {
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
