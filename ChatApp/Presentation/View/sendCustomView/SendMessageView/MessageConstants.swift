//
//  SendMessageConstants.swift
//  ChatApp
//
//  Created by MacBoobPro on 28.04.23.
//

import Foundation
import UIKit

extension MessageView {
    enum Constants {
        
        static let textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        static let textFontSize = UIFont.systemFont(ofSize: 16)
        static let text = "დაწერე შეტყობინება..."
        static let cornerRadius  = 28
        static let viewBorderUIColor = CGColor(red: 0.62, green: 0.38, blue: 1.00, alpha: 1.00)
        static let borderWith = 1
        static let textColor = UIColor.lightGray
        static let image = UIImage(named: "send_button_image")
        static let inputContainerLeadingAnchor = 16
        static let inputContainerTrailingAnchor = -16
        static let inputContainerHeightAnchor = 56
        static let inputContainerBottomAnchor = 16
        static let textViewTrailingAnchor = -5
        static let textViewLeadingngAnchor = 5
        static let textViewBottomAnchor = 8
        static let textViewTopAnchor = 5
        static let tableViewBottom = 16
        static let sendButtonViewWidthAnchor = 32
        
        
    }
}

