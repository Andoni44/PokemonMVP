//
//  RouterProtocol.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import UIKit

protocol RouterProtocol {
    
    func presentAlert(onView view: Any, withTitle title: String, andMessage message: String, actions: [UIAlertAction])
    func createViewController() -> UIViewController
}

extension RouterProtocol {
    
    func presentAlert(onView view: Any, withTitle title: String, andMessage message: String, actions: [UIAlertAction] = []) {
        guard let view = view as? UIViewController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        } else {
            actions.forEach {
                alert.addAction($0)
            }
        }
        DispatchQueue.main.async {
            view.present(alert, animated: true)
        }
    }
    
    var viewController: UIViewController{
        return createViewController()
    }
}
