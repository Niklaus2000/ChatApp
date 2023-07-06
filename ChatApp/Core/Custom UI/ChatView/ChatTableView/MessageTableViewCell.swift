//
//  MessageTableViewCell.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 03.05.23.
//

import UIKit

// MARK: Buble Style
enum BubblePosition {
    case left
    case right
}

final class MessageTableViewCell: UITableViewCell {
    
    // MARK: Variable
    static let reuseIdentifier = "MessageTableViewCell"
    
    private var senderConstraints: [NSLayoutConstraint] = []
    private var receiverConstraints: [NSLayoutConstraint] = []
    
    // MARK: Property
    private lazy var mainBubbleView: UIView = {
        makeBubbleView(cornerRadius: Constants.MainBubleViewLeft.cornerRadius)
    }()
    
    private lazy var messageLabel: UILabel = {
        makeLabel(withFont: Constants.MessageLabelLeft.textFontSize, textColor: .black)
    }()
    
    private lazy var dateLabel: UILabel = {
        makeLabel(withFont: Constants.DateLabelLeft.textFontSize, textColor: .gray)
    }()
    
    private lazy var mediumBubbleView: UIView = {
        makeBubbleView(cornerRadius: Constants.MediumBubleViewLeft.radius)
    }()
    
    private lazy var smallBubbleView: UIView = {
        makeBubbleView(cornerRadius: Constants.SmallBubleViewLeft.radius)
    }()
    
    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        selectionStyle = .none
        
        setUp()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeLabel(withFont font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.numberOfLines = .zero
        return label
    }
    
    private func makeBubbleView(cornerRadius: CGFloat) -> UIView {
        let bubble = UIView()
        bubble.layer.cornerRadius = cornerRadius
        bubble.layer.masksToBounds = true
        return bubble
    }
    
    // MARK: Configure
    func configure(with message: Message, bublePosition: BubblePosition) {
          messageLabel.text = message.text
        dateLabel.text = message.date.formaDate()
        
        if message.isSent && bublePosition == .right {
            dateLabel.text = "არ გაიგზავნა"
            messageLabel.textColor = .gray
            dateLabel.textColor = .red
        } else {
            dateLabel.text = message.date.formaDate()
            dateLabel.textColor = .gray
        }
        
        switch bublePosition {
        case .left:
            NSLayoutConstraint.deactivate(receiverConstraints)
            NSLayoutConstraint.activate(senderConstraints)
            setUpLeftBackgroundColor()
        case .right:
            NSLayoutConstraint.deactivate(senderConstraints)
            NSLayoutConstraint.activate(receiverConstraints)
            setUpRightBackgroundColor()
        }
    }
    
    private func setUpRightBackgroundColor() {
        [mainBubbleView, mediumBubbleView, smallBubbleView].forEach {
            $0.self.backgroundColor = Constants.MainBubleViewRight.backgroundColor
        }
    }
    
    private func setUpLeftBackgroundColor() {
        [mainBubbleView, mediumBubbleView, smallBubbleView].forEach {
            $0.self.backgroundColor = Constants.MainBubleViewLeft.backGroundColor
        }
    }
    
    // MARK: Add ContentView
    private func setUp() {
        [mainBubbleView, messageLabel, dateLabel, mediumBubbleView, smallBubbleView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupViews() {
         senderConstraints = [
            mainBubbleView.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            mainBubbleView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.MainBubleViewLeft.leading),
            mainBubbleView.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor,
                constant: Constants.MainBubleViewLeft.trailing),
            
            messageLabel.topAnchor.constraint(
                equalTo: mainBubbleView.topAnchor,
                constant: Constants.MessageLabelLeft.top),
            messageLabel.leadingAnchor.constraint(
                equalTo: mainBubbleView.leadingAnchor,
                constant: Constants.MessageLabelLeft.leading),
            messageLabel.trailingAnchor.constraint(
                equalTo: mainBubbleView.trailingAnchor,
                constant: Constants.MessageLabelLeft.trailing),
            messageLabel.bottomAnchor.constraint(
                equalTo: mainBubbleView.bottomAnchor,
                constant: Constants.MessageLabelLeft.bottom),
            
            mediumBubbleView.leadingAnchor.constraint(
                equalTo: mainBubbleView.leadingAnchor,
                constant: Constants.MediumBubleViewLeft.leading),
            mediumBubbleView.bottomAnchor.constraint(
                equalTo: mainBubbleView.bottomAnchor,
                constant: Constants.MediumBubleViewLeft.bottom),
            mediumBubbleView.widthAnchor.constraint(
                equalToConstant: Constants.MediumBubleViewLeft.width),
            mediumBubbleView.heightAnchor.constraint(
                equalToConstant: Constants.MediumBubleViewLeft.height),
            
            smallBubbleView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.SmallBubleViewLeft.leading),
            smallBubbleView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: Constants.SmallBubleViewLeft.bottom),
            smallBubbleView.widthAnchor.constraint(
                equalToConstant: Constants.SmallBubleViewLeft.width),
            smallBubbleView.heightAnchor.constraint(
                equalToConstant: Constants.SmallBubleViewLeft.height),
            
            dateLabel.topAnchor.constraint(
                equalTo: mainBubbleView.bottomAnchor,
                constant: Constants.DateLabelLeft.top),
            dateLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.DateLabelLeft.leading),
            dateLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: Constants.DateLabelLeft.bottom)
         ]

         receiverConstraints = [
            mainBubbleView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.MainBubleViewRight.top),
            mainBubbleView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.MainBubleViewRight.trailing),
            mainBubbleView.leadingAnchor.constraint(
                greaterThanOrEqualTo: contentView.leadingAnchor,
                constant: Constants.MainBubleViewRight.leading),
            mainBubbleView.bottomAnchor.constraint(
                equalTo: messageLabel.bottomAnchor,
                constant: Constants.MainBubleViewRight.bottom),
            
            messageLabel.topAnchor.constraint(
                equalTo: mainBubbleView.topAnchor,
                constant: Constants.MessageLabelRight.top),
            messageLabel.trailingAnchor.constraint(
                equalTo: mainBubbleView.trailingAnchor,
                constant: Constants.MessageLabelRight.trailing),
            messageLabel.bottomAnchor.constraint(
                equalTo: mainBubbleView.bottomAnchor,
                constant: Constants.MessageLabelRight.bottom),
            messageLabel.leadingAnchor.constraint(
                equalTo: mainBubbleView.leadingAnchor,
                constant: Constants.MessageLabelRight.leading),
            
            dateLabel.topAnchor.constraint(
                equalTo: mainBubbleView.bottomAnchor,
                constant: Constants.DateLabelRight.top),
            dateLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.DateLabelRight.trailing),
            dateLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: Constants.DateLabelRight.bottom),
            
            mediumBubbleView.trailingAnchor.constraint(
                equalTo: mainBubbleView.trailingAnchor,
                constant: Constants.MediumBubleViewRight.trailing),
            mediumBubbleView.bottomAnchor.constraint(
                equalTo: mainBubbleView.bottomAnchor,
                constant: Constants.MediumBubleViewRight.bottom),
            mediumBubbleView.widthAnchor.constraint(
                equalToConstant: Constants.MediumBubleViewRight.width),
            mediumBubbleView.heightAnchor.constraint(
                equalToConstant: Constants.MediumBubleViewRight.height),
            
            smallBubbleView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.SmallBubleViewRight.trailing),
            smallBubbleView.topAnchor.constraint(
                equalTo: mediumBubbleView.bottomAnchor,
                constant: Constants.SmallBubleViewRight.top),
            smallBubbleView.widthAnchor.constraint(
                equalToConstant: Constants.SmallBubleViewRight.width),
            smallBubbleView.heightAnchor.constraint(
                equalToConstant: Constants.SmallBubleViewRight.height)
         ]
         NSLayoutConstraint.activate(senderConstraints)
     }
}
