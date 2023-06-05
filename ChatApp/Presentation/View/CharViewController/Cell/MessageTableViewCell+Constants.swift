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
        
        // MARK: MainBuble constant
        enum MainBubleViewLeft {
            static let cornerRadius: CGFloat = 25
            static let borderWith: CGFloat = 1
            static let leading: CGFloat = 40
            static let trailing: CGFloat = -16
            static  let backGroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
        }
        
        // MARK: MessageLabelView constant
        enum MessageLabelLeft {
            static let top: CGFloat =  16
            static let bottom: CGFloat = -16
            static let leading: CGFloat = 10
            static let trailing: CGFloat = -16
            static let textFontSize = UIFont.systemFont(ofSize: 16)
        }
        
        // MARK: DateLabelView constant
        enum DateLabelLeft {
            static let top: CGFloat = 4
            static let leading: CGFloat = 60
            static let bottom: CGFloat = -16
            static let textFontSize = UIFont.systemFont(ofSize: 12)
        }
        
        // MARK: FirstBubleView constant
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
            static let bottom: CGFloat = -16
            static let leading: CGFloat = 20
            static let radius: CGFloat = 10
        }
        
        // MARK: SecondBubleView constant
        enum SmallBubleViewRight {
            static let top: CGFloat = -5
            static let trailing: CGFloat = -10
            static let width: CGFloat = 18
            static let height: CGFloat = 18
            static let backgroundColor = UIColor(
                red: 218/255,
                green: 194/255,
                blue: 255/255,
                alpha: 1)
        }
        
        // MARK: SecondBubleView constant
        enum MediumBubleViewRight {
            static let trailing: CGFloat = 4
            static let bottom: CGFloat = 4
            static let width: CGFloat = 22
            static let height: CGFloat = 22
            static let backgroundColor = UIColor(
                red: 218/255,
                green: 194/255,
                blue: 255/255,
                alpha: 1)
        }
        
        // MARK: MainBuble constant
        enum MainBubleViewRight {
            static let top: CGFloat = 5
            static let trailing: CGFloat = -30
            static let leading: CGFloat = 19
            static let bottom: CGFloat = 16
            static let backgroundColor = UIColor(
                red: 218/255,
                green: 194/255,
                blue: 255/255,
                alpha: 1)
        }
        
        // MARK: MessageLabel constant
        enum MessageLabelRight {
            static let top: CGFloat = 16
            static let bottom: CGFloat = 16
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
        }

        // MARK: DateLabel constant
        enum DateLabelRight {
            static let top: CGFloat = 5
            static let trailing: CGFloat = -55
            static let bottom: CGFloat = -16
        }
    }
}

