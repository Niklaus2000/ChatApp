//
//  MessageTableViewCellConstannts.swift
//  ChatApp
//
//  Created by MacBoobPro on 18.05.23.
//

import UIKit

// - MARK: MainBuble constant
extension MessageTableViewCell {
    enum Constants {
    
        // MARK: - MainBuble constant
        enum MainBubleView {
            static let cornerRadius: CGFloat = 25
            static let borderWith: CGFloat = 1
            static let leading: CGFloat = 40
        }
        
        // MARK: - MessageLabelView constant
        enum MessageLabelView {
            static let top: CGFloat =  16
            static let bottom: CGFloat = -16
            static let leading: CGFloat = 10
            static let trailing: CGFloat = -16
            static let textFontSize = UIFont.systemFont(ofSize: 16)
        }
        
        // MARK: - DateLabelView constant
        enum DateLabelView {
            static let top: CGFloat = 4
            static let leading: CGFloat = 50
            static let bottom: CGFloat = -16
            static let textFontSize = UIFont.systemFont(ofSize: 12)
        }
        
        // MARK: - FirstBubleView constant
        enum FirstBubleView {
            static let width: CGFloat = 24
            static let height: CGFloat = 24
            static let bottom: CGFloat = 2
            static let leading: CGFloat = -5
        }
        
        // MARK: - SecondBubleView constant
        enum SecondBubleView {
            static let width: CGFloat = 18
            static let height: CGFloat = 18
            static let bottom: CGFloat = -20
            static let leading: CGFloat = 20
        }
    }
}
