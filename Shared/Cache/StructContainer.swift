//
//  StructContainer.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

class StructContainer<T: Any> {
    let object: T
    
    init(object: T) {
        self.object = object
    }
}
