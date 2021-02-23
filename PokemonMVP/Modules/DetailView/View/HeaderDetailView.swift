//
//  HeaderDetailView.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import UIKit

final class HeaderDetailView: UIView {
    
    private let header: UIView = {
        let stack = UIView()
        return stack
    }()
    
    let nameLabel: UILabel = {
        let component = UILabel()
        component.numberOfLines = 1
        component.font = UIFont(name: App.Fonts.bangersRegular.rawValue, size: 20)
        component.textColor = .white
        component.sizeToFit()
        return component
    }()
    
    private let nameBackground: UIView = {
        let component = UIView()
        component.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        component.layer.cornerRadius = 2
        return component
    }()
    
    let imageView: UIImageView = {
        let component = UIImageView()
        component.backgroundColor = .black
        component.contentMode = .scaleAspectFit
        component.clipsToBounds = true
        component.layer.cornerRadius = 5
        component.image = #imageLiteral(resourceName: "placeholder")
        return component
    }()

    init() {
        super.init(frame: CGRect())
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension HeaderDetailView {
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
        header.addSubview(imageView)
        header.addSubview(nameBackground)
        nameBackground.addSubview(nameLabel)
        header.anchor(topAnchor: topAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, padding: .init(top: .zero, left: 10, bottom: .zero, right: 10))
        imageView.anchor(topAnchor: header.topAnchor, trailingAnchor: header.trailingAnchor, bottomAnchor: header.bottomAnchor, leadingAnchor: header.leadingAnchor)
        nameLabel.anchor(topAnchor: nameBackground.topAnchor, trailingAnchor: nameBackground.trailingAnchor, bottomAnchor: nameBackground.bottomAnchor, leadingAnchor: nameBackground.leadingAnchor, padding: .init(top: 2, left: 5, bottom: 3, right: 5))
        nameBackground.anchor(topAnchor: nil, trailingAnchor: header.trailingAnchor, bottomAnchor: header.bottomAnchor, leadingAnchor: nil, padding: .init(top: .zero, left: .zero, bottom: 10, right: 10))
    }
}
