//
//  UIView+Preview.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 20/2/21.
//

#if DEBUG
import UIKit
import SwiftUI

extension UIView {
    
    var instaView: some View {
        InstaView(view: self)
    }
    
    struct InstaView<V: UIView>: UIViewRepresentable {
        
        let view: V
        
        func makeUIView(context: UIViewRepresentableContext<UIView.InstaView<V>>) -> V {
            return view
        }
        
        func updateUIView(_ uiView: V, context: UIViewRepresentableContext<InstaView<V>>) {
            
        }
    }
}

#endif
