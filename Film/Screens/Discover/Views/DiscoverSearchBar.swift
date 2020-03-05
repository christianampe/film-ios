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
        vStack.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        vStack.layoutIfNeeded()
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "magnifyingglass")
        return imageView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.text = "Hello world"
        textField.autoresizingMask = .flexibleWidth
        return textField
    }()
    
    private lazy var underlineView: UIView = {
        let underlineView = UIView()
        underlineView.frame.size.height = 2
        underlineView.backgroundColor = .systemFill
        return underlineView
    }()
    
    private lazy var hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.alignment = .leading
        hStack.distribution = .fill
        hStack.addArrangedSubview(imageView)
        hStack.addArrangedSubview(textField)
        return hStack
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .bottom
        vStack.distribution = .fill
        vStack.addArrangedSubview(hStack)
        vStack.addArrangedSubview(underlineView)
        addSubview(vStack)
        vStack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return vStack
    }()
    
}
