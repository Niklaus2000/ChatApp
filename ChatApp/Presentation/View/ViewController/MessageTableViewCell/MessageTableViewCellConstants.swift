//
//  MessageTableViewCellConstannts.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 18.05.23.
//

import UIKit

// - MARK: MainBuble constant
extension MessageTableViewCell {
    enum Constants {
    
        // MARK: - MainBuble constant
        enum MainBubleViewLeft {
            static let cornerRadius: CGFloat = 25
            static let borderWith: CGFloat = 1
            static let leading: CGFloat = 40
        }
        
        // MARK: - MessageLabelView constant
        enum MessageLabelLeft {
            static let top: CGFloat =  16
            static let bottom: CGFloat = -16
            static let leading: CGFloat = 10
            static let trailing: CGFloat = -16
            static let textFontSize = UIFont.systemFont(ofSize: 16)
        }
        
        // MARK: - DateLabelView constant
        enum DateLabelLeft {
            static let top: CGFloat = 4
            static let leading: CGFloat = 50
            static let bottom: CGFloat = -16
            static let textFontSize = UIFont.systemFont(ofSize: 12)
        }
        
        // MARK: - FirstBubleView constant
        enum MediumBubleViewLeft {
            static let width: CGFloat = 24
            static let height: CGFloat = 24
            static let bottom: CGFloat = 6
            static let leading: CGFloat = -5
            static let radius: CGFloat = 12
        }
        
        // MARK: - SecondBubleView constant
        enum SmallBubleViewLeft {
            static let width: CGFloat = 18
            static let height: CGFloat = 18
            static let bottom: CGFloat = -3
            static let leading: CGFloat = 20
            static let radius: CGFloat = 10
        }
        // MARK: - MainBuble constant
        enum MainBubleViewRight {
            static let leading: CGFloat = -10
            static let top: CGFloat = 16
            static let trailing: CGFloat = -30
            static let bottom: CGFloat = 16
           
        }
        
        // MARK: - MessageLabelView constant
        enum MessageLabelRight {
            static let top: CGFloat =  16
            static let bottom: CGFloat = -16
            static let leading: CGFloat = 10
            static let trailing: CGFloat = -16
        }
        
        // MARK: - DateLabelView constant
        enum DateLabelRight {
            static let top: CGFloat = 5
            static let bottom: CGFloat = 16
            static let trailing: CGFloat = -50
        }
        
        // MARK: - FirstBubleView constant
        enum MediumBubleViewRight {
            static let width: CGFloat = 24
            static let height: CGFloat = 24
            static let bottom: CGFloat = 4
            static let trailing: CGFloat = 4
        }
        
        // MARK: - SecondBubleView constant
        enum SmallBubleViewRight {
            static let width: CGFloat = 18
            static let height: CGFloat = 18
            static let top: CGFloat = -5
            static let trailing: CGFloat = -10
            static let radius: CGFloat = 10
        }
    }
}
    

