//
//  MessageView.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 29.05.23.
//

import UIKit


final class ChatView: UIView {
    
    // MARK: Property
    let messageTextView = MessageTextView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        setUpTableViewConstraints()
        setUpMessageTextView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: add Subview
    private func setUp() {
        [tableView, messageTextView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // MARK: Constraint
    private func setUpTableViewConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.top),
            tableView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.leading),
            tableView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.trailing),
        ])
    }
    
    func setUpMessageTextView(){
        NSLayoutConstraint.activate([
            messageTextView.topAnchor.constraint(
                equalTo: tableView.bottomAnchor),
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
//extension ChatView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        messages.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
//        
//        let message = messages[indexPath.row]
//        cell.configure(with: message, bublePosition: message.userID == 1 ? .left: .right)
//        return cell
//    }
//}
