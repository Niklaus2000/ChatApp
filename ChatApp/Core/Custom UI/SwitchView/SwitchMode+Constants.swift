//
//  SwitchModeConstants.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 28.04.23.
//

import UIKit

// MARK: - Extension
extension SwitchModeView {
    struct LocalConstants {
        static let light = UIImage(named: "light_image_view")
        static let dark = UIImage(named: "dark_image_view")
    }
    
    // MARK: Extension
    enum ButtonState {
        case light
        case dark
    }
}
