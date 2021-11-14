//
//  SceneDelegate.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 19/2/21.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        loadLog()
        let homeView = HomeRouter().viewController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor(named: App.Colors.main.rawValue)
        window?.windowScene = windowScene
        window?.rootViewController = homeView
        window?.makeKeyAndVisible()
    }
}

// MARK: - Inner methods
private extension SceneDelegate {
    func loadLog() {
        let appVersion = String(UIApplication.appVersion)
#if DEBUG
        Logger.configure(appVersion: appVersion, logLevel: .debug)
#else
        Logger.configure(appVersion: appVersion, logLevel: .info)
#endif
    }
}
