//
//  DiscoverFilmHeader.swift
//  Film
//
//  Created by Christian Ampe on 3/7/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

final class DiscoverFilmHeader: UICollectionReusableView {
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
}

extension DiscoverFilmHeader {
    func setTitle(_ title: String) {
        label.text = title
    }
}

private extension DiscoverFilmHeader {
    func initialize() {
        label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          label.leadingAnchor.constraint(equalTo: leadingAnchor),
          label.trailingAnchor.constraint(equalTo: trailingAnchor),
          label.topAnchor.constraint(equalTo: topAnchor),
          label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
