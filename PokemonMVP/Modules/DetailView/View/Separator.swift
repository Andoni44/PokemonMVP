//
//  Separator.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import UIKit

final class Separator: UIView {
    
    private var color: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        self.color = color
        setColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setColor() {
        if let color = self.color {
            backgroundColor = color
        } else {
            backgroundColor = .gray
        }
    }
    
    private func setup() {
        setColor()
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
