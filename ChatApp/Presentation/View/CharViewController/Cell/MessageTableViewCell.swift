//
//  MessageTableViewCell.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 03.05.23.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {
    
    // MARK: Variable
    static let reuseIdentifier = "MessageTableViewCell"
    var leadingConstraint = NSLayoutConstraint()
    var trailingConstraint = NSLayoutConstraint()
    
    // MARK: Property
    private lazy var mainBubbleView: UIView = {
        makeBubbleView(cornerRadius: Constants.MainBubleViewLeft.cornerRadius)
    }()
    
    private lazy var messageLabel: UILabel = {
        makeLabel(withFont: Constants.MessageLabelLeft.textFontSize, textColor: .white)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeLabel(withFont font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        return label
    }
    
    private func makeBubbleView(cornerRadius: CGFloat) -> UIView {
        let bubble = UIView()
        bubble.layer.cornerRadius = cornerRadius
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = .gray
        return bubble
    }
    
    // MARK: Configure
    func configure(with message: String, indexpath: IndexPath) {
        messageLabel.text = message
        
        if indexpath.row == 0 || indexpath.row == 2 {
            setUpLeftConstraint()
        } else if indexpath.row == 1 {
            setUpRightConsstraint()
        }
    }
    
    // MARK: Add ContentView
    private func setUp() {
        [mainBubbleView, messageLabel, dateLabel, mediumBubbleView, smallBubbleView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // MARK: SetUp
    private func setUpLeftConstraint() {
        setUpMainBubleConstraints()
        setUpMessageLabelConstraints()
        setUpDateViewConstraints()
        setUpMediumBubleViewConstraints()
        setUpSmallBubleViewConstraints()
    }
    
    private func setUpRightConsstraint() {
        setUpChatBubbleConstraintsSecond()
        setUpMessageLabelConstraintsSecond()
        setUpDateLabelConstraintsSecond()
        setUpMediumBubbleViewConstraintsSecond()
        setUpSmallBubbleViewConstraintsSecond()
    }
    
    // MARK: Constraints
    private func setUpMainBubleConstraints() {
        NSLayoutConstraint.activate([
            mainBubbleView.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            mainBubbleView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.MainBubleViewLeft.leading),
        ])
    }
    
    private func setUpMessageLabelConstraints() {
        NSLayoutConstraint.activate([
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
        ])
    }
    
    private func setUpMediumBubleViewConstraints() {
        NSLayoutConstraint.activate([
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
        ])
    }
    
    private func setUpSmallBubleViewConstraints() {
        NSLayoutConstraint.activate([
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
        ])
    }
    
    private func setUpDateViewConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(
                equalTo: mainBubbleView.bottomAnchor,
                constant: Constants.DateLabelLeft.top),
            dateLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.DateLabelLeft.leading),
            dateLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: Constants.DateLabelLeft.bottom)
        ])
    }
    
    private func setUpChatBubbleConstraintsSecond() {
        NSLayoutConstraint.activate([
            mainBubbleView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.MainBubleViewRight.top),
            mainBubbleView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.MainBubleViewRight.trailing),
            mainBubbleView.bottomAnchor.constraint(
                equalTo: messageLabel.bottomAnchor,
                constant: Constants.MainBubleViewRight.bottom),
        ])
    }
    
    private func setUpMessageLabelConstraintsSecond() {
        NSLayoutConstraint.activate([
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
                constant: Constants.MessageLabelRight.leading)
        ])
    }
    
    private func setUpDateLabelConstraintsSecond() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(
                equalTo: mainBubbleView.bottomAnchor,
                constant: Constants.DateLabelRight.top),
            dateLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.DateLabelRight.trailing),
            dateLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: Constants.DateLabelRight.bottom)
        ])
    }
    
    private func setUpMediumBubbleViewConstraintsSecond() {
        NSLayoutConstraint.activate([
            mediumBubbleView.trailingAnchor.constraint(
                equalTo: mainBubbleView.trailingAnchor,
                constant: Constants.MediumBubleViewRight.trailing),
            mediumBubbleView.bottomAnchor.constraint(
                equalTo: mainBubbleView.bottomAnchor,
                constant: Constants.MediumBubleViewRight.bottom),
            mediumBubbleView.widthAnchor.constraint(
                equalToConstant: Constants.MediumBubleViewRight.width),
            mediumBubbleView.heightAnchor.constraint(
                equalToConstant: Constants.MediumBubleViewRight.height)
        ])
    }
    
    private func setUpSmallBubbleViewConstraintsSecond() {
        NSLayoutConstraint.activate([
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
        ])
    }
}
