//
//  UIView+Anchor.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import UIKit

extension UIView {
    
    func anchor(topAnchor: NSLayoutYAxisAnchor?, trailingAnchor: NSLayoutXAxisAnchor?, bottomAnchor: NSLayoutYAxisAnchor?, leadingAnchor: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
        }
        if let leadingAnchor = leadingAnchor {
            self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
        }
        if let trailingAnchor = trailingAnchor {
            self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
        }
        if let bottomAnchor = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
}
