//
//  Array++.swift
//  Film
//
//  Created by Christian Ampe on 3/2/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

extension Array {
    
    /// Public array accessor returning the item from the array or a default object if no item is at that index.
    ///
    /// - Parameters:
    ///   - index: The index to be extracted.
    ///   - defaultValue: The default value to be returned if there is no item at the index.
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        
        return self[index]
    }
    
    /// Public array accessor returning an optional if there is no item at that index.
    ///
    /// - Parameter index: The index to be extracted.
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
