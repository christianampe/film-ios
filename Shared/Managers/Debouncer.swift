//
//  Debouncer.swift
//  Film
//
//  Created by Christian Ampe on 3/6/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import Foundation

final class Debouncer {
    private let delay: TimeInterval
    private var timer: Timer?
    
    var handler: (() -> Void)?
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
}

extension Debouncer {
    func call() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] timer in
            guard timer.isValid else {
                return
            }
            
            self?.handler?()
        }
    }
}
