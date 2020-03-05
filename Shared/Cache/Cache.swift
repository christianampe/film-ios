//
//  Cache.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

class Cache<T: Any> {
    private let storage = NSCache<NSString, AnyObject>()
}

extension Cache {
    func insert(_ object: T, forKey key: String) {
        guard let classObject = classObject(from: object) else {
            return
        }
        
        storage.setObject(classObject, forKey: key as NSString)
    }
    
    func object(forKey key: String) -> T? {
        guard let object = storage.object(forKey: key as NSString) else {
            return nil
        }
        
        if let castedObject = object as? T {
            return castedObject
        } else if let containerObject = object as? StructContainer<T> {
            return containerObject.object
        } else {
            return nil
        }
    }
}

private extension Cache {
    func classObject(from object: T) -> AnyObject? {
        guard let displayStyle = Mirror(reflecting: object).displayStyle else {
            return nil
        }
        
        switch displayStyle {
        case .class:
            return object as AnyObject
        case .collection:
            return object as AnyObject
        case .struct:
            return StructContainer(object: object)
        default:
            return nil
        }
    }
}
