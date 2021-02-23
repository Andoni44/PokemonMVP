//
//  UIview+ShadowView.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import UIKit

final class ShadowView: UIView {

   var cornerRadius: CGFloat = 0.0 {
       didSet {
          setNeedsLayout()
       }
    }
    var shadowColor: UIColor = UIColor.darkGray {
       didSet {
          setNeedsLayout()
       }
    }
    var shadowOffsetWidth: CGFloat = 0.0 {
       didSet {
          setNeedsLayout()
       }
    }
    var shadowOffsetHeight: CGFloat = 1.8 {
       didSet {
          setNeedsLayout()
       }
    }
    var shadowOpacity: Float = 0.30 {
       didSet {
          setNeedsLayout()
       }
    }
    var shadowRadius: CGFloat = 3.0 {
       didSet {
          setNeedsLayout()
       }
    }
    
    private var shadowLayer: CAShapeLayer = CAShapeLayer() {
       didSet {
          setNeedsLayout()
       }
    }

    override func layoutSubviews() {
       super.layoutSubviews()
       layer.cornerRadius = cornerRadius
       shadowLayer.path = UIBezierPath(roundedRect: bounds,
          cornerRadius: cornerRadius).cgPath
       shadowLayer.fillColor = backgroundColor?.cgColor
       shadowLayer.shadowColor = shadowColor.cgColor
       shadowLayer.shadowPath = shadowLayer.path
       shadowLayer.shadowOffset = CGSize(width: shadowOffsetWidth,
          height: shadowOffsetHeight)
       shadowLayer.shadowOpacity = shadowOpacity
       shadowLayer.shadowRadius = shadowRadius
       layer.insertSublayer(shadowLayer, at: 0)
    }

}


