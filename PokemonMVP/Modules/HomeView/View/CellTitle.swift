//
//  CellTitle.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import UIKit

final class CellTitle: UIView {
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    convenience init(with title: String) {
        self.init()
        self.title = title
        setupViews()
    }
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.9
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: App.Fonts.bangersRegular.rawValue, size: 18)
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    /// A size suggestion.
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 400, height: 10)
    }
}

//MARK: - View setup
private extension CellTitle {
    
   func setupViews() {
        addSubview(background)
        background.addSubview(titleLabel)
        background.anchor(topAnchor: topAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor)
        titleLabel.anchor(topAnchor: background.topAnchor, trailingAnchor: nil, bottomAnchor: background.bottomAnchor, leadingAnchor: background.leadingAnchor, padding: .init(top: 2, left: 10, bottom: 3, right: .zero))
    }
}

