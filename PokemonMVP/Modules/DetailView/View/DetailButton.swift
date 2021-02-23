//
//  DetailButton.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

import UIKit

final class DetailButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, color: UIColor, insets: UIEdgeInsets) {
        self.init(frame: .zero)
        setTitle(text, for: .normal)
        backgroundColor = color
        titleEdgeInsets = insets
        configure()
    }
    
    convenience init(text: String, color: UIColor, insets: UIEdgeInsets, font: UIFont, corner: CGFloat) {
        self.init(frame: .zero)
        setTitle(text, for: .normal)
        backgroundColor = color
        if color == .clear {
            layer.borderWidth = 2
            layer.borderColor = UIColor.white.cgColor
        }
        titleEdgeInsets = insets
        self.addTarget(self, action: #selector(selectionAnimation), for: .touchUpInside)
        configure(font: font, corner: corner)
    }
    
    private func configure(font: UIFont = UIFont.systemFont(ofSize: 20, weight: .medium), corner: CGFloat = 5) {
        layer.cornerRadius = corner
        titleLabel?.font =  font
        setTitleColor(.white, for: .normal)
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.textAlignment = .center
    }
    
    private func configure(image: UIImage, corner: CGFloat, color: UIColor) {
        layer.cornerRadius = corner
        imageView?.contentMode = .scaleAspectFit
        imageView?.tintColor = #colorLiteral(red: 0.3387862979, green: 0.5772582401, blue: 0.5119804772, alpha: 1)
        setImage(image, for: UIControl.State.normal)
        backgroundColor = color
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 6, bottom: 10, right: 6)
    }
    
    @objc func selectionAnimation() {
        self.center.y -= 20
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        self.alpha = 0.5
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.center.y += 20
            self.transform = CGAffineTransform.identity
            self.alpha = 1
            
        }, completion: nil)
    }
}


