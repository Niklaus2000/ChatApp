//
//  MessageView.swift
//  ChatApp
//
//  Created by MacBoobPro on 29.05.23.
//

import UIKit

// MARK: - MessageStyle
let messages: [Message] = [
    Message(userID: 1, text: "დასწერhbaksdasdasjdnsaknxalskxnaxscjnsaknaskncanscasnasnlcnalacnanscnalncsancalnscanე", date: "11.11.1111"),
    Message(userID: 2, text: "csancihasnjlnlnslfjdnfdslflsjndfldsknfsldnvknsmv lvsmdvsngmengmlvnmwfnklwqknnvjwmflwnvnsknvwjvnsljvnv", date: "11.11.1111"),
    Message(userID: 1, text: "დასწერედსასჰბდაჯსკნდასბნკ,ნაჯ სხ,ხ აკსხ ჯკანსკხჯა ხბსკხნსა ხბხკ,ანხხ ბხაჯკნ სხახბნხასჯნხკა", date: "11.11.1111"),
    Message(userID: 2, text: "მამწეკჯხნაკსნკხან კხ აკსნხკასნკხჯდკსანკდნაკსნდკჯსანნკაჯნხხკხანსკჯხნაკხნაკსნხაკსნხკახნკხახნკასნხკასნხკაკახნსხნხა", date: "11.11.1111"),
    Message(userID: 1, text: "მამწერენდკანსკდნაკსნდკასნკადინასდჯნასინდაკსჯნდკნასკდნაკსდკნასკნდკა დკნასმნდანსკდნანდკსანკდნას", date: "11.11.1111"),
    Message(userID: 1, text: "დასწერhbaksdasdasjdnsaknxalskxnaxscjnsaknaskncanscasnasnlcnalacnanscnalncsancalnscanე", date: "11.11.1111"),
    Message(userID: 2, text: "csancihasnjlnlnslfjdnfdslflsjndfldsknfsldnvknsmv lvsmdvsngmengmlvnmwfnklwqknnvjwmflwnvnsknvwjvnsljvnv", date: "11.11.1111"),
    Message(userID: 1, text: "დასწერედსასჰბდაჯსკნდასბნკ,ნაჯ სხ,ხ აკსხ ჯკანსკხჯა ხბსკხნსა ხბხკ,ანხხ ბხაჯკნ სხახბნხასჯნხკა", date: "11.11.1111"),
    Message(userID: 2, text: "მამწეკჯხნაკსნკხან კხ აკსნხკასნკხნკაჯნხხკხანსკჯხნაკხნაკსნხაკსნხკახნკხახნკასნხკასნხკაკახნსხნხა", date: "11.11.1111"),
    Message(userID: 1, text: "მამწერენდკანსკდნაკსნდკასნკადინასდჯნასინდაკსჯნდკნასკდნაკსდკნასკნდკდასჰდნკდასნდკასნკდნსაკნდკსანდკანსკდნაკდნსკაა დკნასმნდანსკდნანდკსანკდნას", date: "11.11.1111")
]

final class MessageView: UIView {
    
    // MARK: Property
    private let messageTextView = MessageTextView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
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
    
    private func setUpMessageTextView(){
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
extension MessageView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        
        let message = messages[indexPath.row]
        cell.configure(with: message, bublePosition: message.userID == 1 ? .left: .right)
        return cell
    }
}
