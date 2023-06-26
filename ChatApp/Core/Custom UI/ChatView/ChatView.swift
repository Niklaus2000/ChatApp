//
//  MessageView.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 29.05.23.
//

import UIKit

protocol ChatViewDelegate: AnyObject {
    func didSendMessage(message: Message)
}

final class ChatView: UIView {
    
    // MARK: Property
    private let messageTextView = MessageTextView()
    weak var delegate: ChatViewDelegate?
    var loggedInUserID: Int
    var messages: [Message]
    private let network = NetworkManager()
    
    private lazy var messageTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(
            MessageTableViewCell.self,
            forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: Init
    init(loggedInUserID: Int, messages: [Message]) {
        self.loggedInUserID = loggedInUserID
        self.messages = messages
        super.init(frame: .zero)
        setUp()
        setUpTableViewConstraints()
        setUpMessageTextView()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadTableView(messages: [Message]) {
        self.messages = messages
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
        messageTextView.delegate = self
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

// MARK: - UITableViewDataSource
extension ChatView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        
        let message = messages[indexPath.row]
        cell.configure(with: message, bublePosition: message.userId != loggedInUserID ? .left : .right)
        
        return cell
    }
}

// MARK: - TextInputComponentViewDelegate
extension ChatView: MessageTextViewDelegate {
    
    func didTapButton(text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let lines = trimmedText.components(separatedBy: "\n")
        let nonEmptyLines = lines.filter { !$0.isEmpty }
        let finalText = nonEmptyLines.joined(separator: "\n")
        
        if !finalText.isEmpty {
            delegate?.didSendMessage(message: Message(userId: loggedInUserID, text: finalText, date: Date(), isSent: !network.isInternetAvailable()))
        }
    }
}



