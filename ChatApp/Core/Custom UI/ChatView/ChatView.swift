//
//  MessageView.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 29.05.23.
//

import UIKit

protocol ChatViewDelegate: AnyObject {
    func didSendMessage(chatView: ChatView, text: String, date: Date, userId: Int)
}

final class ChatView: UIView {
    
    // MARK: Property
    private let messageTextView = MessageTextView()
    weak var delegate: ChatViewDelegate?
    private var loggedInUserID = 0
    
    private var messageTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(
            MessageTableViewCell.self,
            forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        setUpTableViewConstraints()
        setUpMessageTextView()
        
        messageTextView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLoggedInUserId(loggedInUserId : Int){
        self.loggedInUserID = loggedInUserId
    }
    
    func getTableView() -> UITableView {
        messageTableView
    }
    
    func reloadTableView() {
        messageTableView.reloadData()
    }
    
    func configTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        messageTableView.dataSource = dataSource
        messageTableView.delegate = delegate
    }
    
    // MARK: add Subview
    private func setUp() {
        [messageTableView, messageTextView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // MARK: Constraint
    private func setUpTableViewConstraints(){
        NSLayoutConstraint.activate([
            messageTableView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.top),
            messageTableView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.leading),
            messageTableView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.trailing),
        ])
    }
    
    private func setUpMessageTextView(){
        NSLayoutConstraint.activate([
            messageTextView.topAnchor.constraint(
                equalTo: messageTableView.bottomAnchor),
            messageTextView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            messageTextView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            messageTextView.leadingAnchor.constraint(
                equalTo: leadingAnchor)
        ])
    }
}

// MARK: - TextInputComponentViewDelegate
extension ChatView: MessageTextViewDelegate {
    func didTapButton(text: String, date: String) {
        delegate?.didSendMessage(chatView: self, text: text, date: Date(), userId: loggedInUserID)
    }
}



