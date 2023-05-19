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
    
    // MARK: Property
    private lazy var mainBubbleView: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = 25
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = .gray
        return bubble
    }()
    
    private lazy var messageLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var dateLabelView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var firsBubbleView: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = 12
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = .gray
        return bubble
    }()
    
    private lazy var secondBubbleView: UIView = {
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
        
        setUpViewFunc()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: SetUp func
    private func setUpViewFunc() {
        setUpView()
        setUpMainBubleConstraints()
        setUpMessageLabelViewConstraints()
        setUpFirstBubleViewConstraints()
        setUpSecondBubleViewConstraints()
        setUpDateLabelViewConstraaints()
    }
    
    // MARK: Configure
    func configure(with message: Message) {
        messageLabelView.text = message.text
        dateLabelView.text = message.date
    }
    
    // MARK: Add ContentView
    private func setUpView() {
        [mainBubbleView, firsBubbleView, secondBubbleView, dateLabelView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        mainBubbleView.addSubview(messageLabelView)
        messageLabelView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: MainBuble Constraints
    private func setUpMainBubleConstraints() {
        NSLayoutConstraint.activate([
            mainBubbleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainBubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.MainBubleView.leading),

        ])
    }
    
    // MARK: MessageLabel Constraints
    private func setUpMessageLabelViewConstraints() {
        NSLayoutConstraint.activate([
            messageLabelView.topAnchor.constraint(equalTo: mainBubbleView.topAnchor, constant: Constants.MessageLabelView.top),
            messageLabelView.leadingAnchor.constraint(equalTo: mainBubbleView.leadingAnchor, constant: Constants.MessageLabelView.leading),
            messageLabelView.trailingAnchor.constraint(equalTo: mainBubbleView.trailingAnchor, constant: Constants.MessageLabelView.trailing),
            messageLabelView.bottomAnchor.constraint(equalTo: mainBubbleView.bottomAnchor, constant: Constants.MessageLabelView.bottom),
        ])
    }
    
    // MARK: FirsBubble Constraints
    private func setUpFirstBubleViewConstraints() {
        NSLayoutConstraint.activate([
            firsBubbleView.leadingAnchor.constraint(equalTo: mainBubbleView.leadingAnchor, constant: Constants.FirstBubleView.leading),
            firsBubbleView.bottomAnchor.constraint(equalTo: mainBubbleView.bottomAnchor, constant: Constants.FirstBubleView.bottom),
            firsBubbleView.widthAnchor.constraint(equalToConstant: Constants.FirstBubleView.width),
            firsBubbleView.heightAnchor.constraint(equalToConstant: Constants.FirstBubleView.height),
        ])
    }
    
    // MARK: SecondBubble Constraints
    private func setUpSecondBubleViewConstraints() {
        NSLayoutConstraint.activate([
            secondBubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.SecondBubleView.leading),
            secondBubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.SecondBubleView.bottom),
            secondBubbleView.widthAnchor.constraint(equalToConstant: Constants.SecondBubleView.width),
            secondBubbleView.heightAnchor.constraint(equalToConstant: Constants.SecondBubleView.height),
        ])
    }
    
    // MARK: DateLabel Constraints
    private func setUpDateLabelViewConstraaints() {
        NSLayoutConstraint.activate([
            dateLabelView.topAnchor.constraint(equalTo: mainBubbleView.bottomAnchor, constant: Constants.DateLabelView.top),
            dateLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.DateLabelView.leading),
            dateLabelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.DateLabelView.bottom)
        ])
    }
}

