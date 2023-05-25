//
//  ViewControllerConstants.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 01.05.23.
//

import Foundation
import UIKit

// MARK: - ViewController Constants
extension ChatViewController {
    enum Constants {
        
        // MARK: - DivederView Constants
        enum DivederView {
            static let height: CGFloat =  6
            static let top: CGFloat = 30
            static let bottom: CGFloat = -10
        }
    
        // MARK: - SwitchView Constants
        enum SwitchButtonView {
            static let top: CGFloat = 8
            static let trailing: CGFloat = -12
            static let width: CGFloat = 54
            static let height: CGFloat = 27
            static let backGroundColor = UIColor(red: 0.1804, green: 0, blue: 0.4471, alpha: 1)
        }
        
        enum StackView {
            static let bottom: CGFloat = -20
        }
    }
}
