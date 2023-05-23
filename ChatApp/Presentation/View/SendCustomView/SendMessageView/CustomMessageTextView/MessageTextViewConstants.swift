//
//  MessageTextViewConstants.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 04.05.23.
//

import UIKit

// MARK: MessageTextView constraint
extension MessageTextView {
    enum Constants {
    
        // MARK: InputContainenrView constant
        enum InputContainenrView {
            static let viewBorderUIColor = UIColor(red: 0.62, green: 0.38, blue: 1.00, alpha: 1.00).cgColor
            static let borderWith: CGFloat = 1
            static let cornerRadius: CGFloat = 28
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let bottom: CGFloat = 30
            static let height: CGFloat = 120
        }
        
        // MARK: TextView constant
        enum TextView {
            static let textContainerInset = UIEdgeInsets(top: 15, left: 18, bottom: 15, right: 5)
            static let top: CGFloat = 10
            static let bottom: CGFloat = -10
            static let leading: CGFloat = 10
            static let trailing: CGFloat = -5
            static let textFontSize = UIFont.systemFont(ofSize: 16)
            static let height: CGFloat = 56
            static let maxLines = 5
            static let text = "დაწერე შეტყობინება..."
            static let placeholderColor = UIColor(red: 0.884, green: 0.884, blue: 0.884, alpha: 1)
            static let lightModeTextColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        }
        
        // MARK: ButtonView constant
        enum ButtonView {
            static let width: CGFloat = 32
            static let height: CGFloat = 32
            static let bottom: CGFloat = -12
            static let trailing: CGFloat = -12
            static let image = UIImage(named: "send_button_image")
        }
    }
}
