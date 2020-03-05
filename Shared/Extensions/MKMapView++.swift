//
//  MKMapView++.swift
//  Film
//
//  Created by Christian Ampe on 3/4/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import MapKit

extension MKMapView {
    func dequeueReusableAnnotationView<T: MKAnnotationView>(_ view: T.Type, for annotation: MKAnnotation) -> MKAnnotationView {
        dequeueReusableAnnotationView(withIdentifier: String(describing: T.self), for: annotation)
    }
    
    func register<T: MKAnnotationView>(_ view: T.Type) {
        register(T.self, forAnnotationViewWithReuseIdentifier: String(describing: T.self))
    }
}
