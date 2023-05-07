//
//  MessageTextViewConstants.swift
//  ChatApp
//
//  Created by MacBoobPro on 04.05.23.
//

import Foundation
import UIKit

extension MessageTextView {
    enum Constants {
       //Mark
        enum InputContainenrView {
            static let viewBorderUIColor = UIColor(red: 0.62, green: 0.38, blue: 1.00, alpha: 1.00).cgColor
            static let borderWith: CGFloat = 1
            static let cornerRadius: CGFloat = 28
            static let inputContainerLeadingAnchor: CGFloat = 16
            static let inputContainerTrailingAnchor: CGFloat = -16
        }
        
        
        enum TextView {
            static let textContainerInset = UIEdgeInsets(top: 15, left: 18, bottom: 15, right: 5)
            static let textViewTopAnchor: CGFloat =  10
            static let textViewBottomAnchor: CGFloat =  -10
            static let textViewLeadingAnchor: CGFloat = 10
            static let textViewTrailingAnchor: CGFloat = -5
            static let textFontSize = UIFont.systemFont(ofSize: 16)
            static let textViewHeightConstraint: CGFloat = 56
            static let maxLines = 5
            static let text = "დაწერე შეტყობინება..."
        }
        
        enum ButtonView {
            static let sendButtonViewWidthAnchor: CGFloat = 32
            static let sendButtonViewHeightAnchor: CGFloat = 32
            static let sendButtonViewBottomAnchor: CGFloat = -12
            static let sendButtonViewTrailingAnchor: CGFloat = -10
            static let image = UIImage(named: "send_button_image")
        }
    }
}
