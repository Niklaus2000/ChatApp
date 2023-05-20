//
//  MessageTableViewCell.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 03.05.23.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    // MARK: Variable
    static let reuseIdentifier = "MessageTableViewCell"
    var leadingConstraint = NSLayoutConstraint()
    var trailingConstraint = NSLayoutConstraint()
    
    // MARK: Property
    private lazy var mainBubbleView: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = 25
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = .gray
        return bubble
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var mediumBubbleView: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = 12
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = .gray
        return bubble
    }()
    
    private lazy var smallBubbleView: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = 10
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = . gray
        return bubble
    }()
    
    
    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        selectionStyle = .none
        setUp()
        
        NSLayoutConstraint.activate(cellConstraints)
        leadingConstraint = messageBody.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        leadingConstraint.isActive = false
        trailingConstraint = messageBody.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        trailingConstraint.isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp
    private func setUp() {
        setUpView()
        setUpMainBubleConstraints()
        setUpMessageLabelViewConstraints()
        setUpFirstBubleViewConstraints()
        setUpSecondBubleViewConstraints()
        setUpDateLabelViewConstraaints()
    }
    
    // MARK: Configure
    func configure(with message: Message) {
        messageLabel.text = message.text
        dateLabel.text = message.date
    }
    
    // MARK: Add ContentView
    private func setUpView() {
        [mainBubbleView, mediumBubbleView, smallBubbleView, dateLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        mainBubbleView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Constraints
    private func setUpMainBubleConstraints() {
        NSLayoutConstraint.activate([
            mainBubbleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainBubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.MainBubleView.leading),
            
        ])
    }
    
    private func setUpMessageLabelViewConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: mainBubbleView.topAnchor, constant: Constants.MessageLabel.top),
            messageLabel.leadingAnchor.constraint(equalTo: mainBubbleView.leadingAnchor, constant: Constants.MessageLabel.leading),
            messageLabel.trailingAnchor.constraint(equalTo: mainBubbleView.trailingAnchor, constant: Constants.MessageLabel.trailing),
            messageLabel.bottomAnchor.constraint(equalTo: mainBubbleView.bottomAnchor, constant: Constants.MessageLabel.bottom),
        ])
    }
    
    private func setUpFirstBubleViewConstraints() {
        NSLayoutConstraint.activate([
            mediumBubbleView.leadingAnchor.constraint(equalTo: mainBubbleView.leadingAnchor, constant: Constants.MediumBubleView.leading),
            mediumBubbleView.bottomAnchor.constraint(equalTo: mainBubbleView.bottomAnchor, constant: Constants.MediumBubleView.bottom),
            mediumBubbleView.widthAnchor.constraint(equalToConstant: Constants.MediumBubleView.width),
            mediumBubbleView.heightAnchor.constraint(equalToConstant: Constants.MediumBubleView.height),
        ])
    }
    
    private func setUpSecondBubleViewConstraints() {
        NSLayoutConstraint.activate([
            smallBubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.SmallBubleView.leading),
            smallBubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.SmallBubleView.bottom),
            smallBubbleView.widthAnchor.constraint(equalToConstant: Constants.SmallBubleView.width),
            smallBubbleView.heightAnchor.constraint(equalToConstant: Constants.SmallBubleView.height),
        ])
    }
    
    private func setUpDateLabelViewConstraaints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: mainBubbleView.bottomAnchor, constant: Constants.DateLabel.top),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.DateLabel.leading),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.DateLabel.bottom)
        ])
    }
}

