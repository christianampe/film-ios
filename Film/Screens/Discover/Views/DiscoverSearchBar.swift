//
//  DiscoverSearchBar.swift
//  Film
//
//  Created by Christian Ampe on 3/5/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

final class DiscoverSearchBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .label
        return imageView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search..."
        textField.tintColor = .label
        return textField
    }()
    
    private lazy var underlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = .label
        return underlineView
    }()
    
    weak var delegate: DiscoverSearchBarDelegate?
    
}

private extension DiscoverSearchBar {
    func layout() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(underlineView)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        underlineView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        underlineView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        underlineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
