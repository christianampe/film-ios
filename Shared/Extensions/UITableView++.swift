//
//  UITableView++.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func registerTableViewCell<T: UITableViewCell>(_ cell: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
}
