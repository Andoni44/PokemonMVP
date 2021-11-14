//
//  UIApplication+AppVersion.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 1/11/21.
//

import Foundation
import UIKit

extension UIApplication {
    static var appVersion: String {
        guard let info = Bundle.main.infoDictionary,
              let appVersion = info["CFBundleShortVersionString"] as? String else { return "Unknown" }
        return appVersion
    }
}
