import UIKit

final class MessageView: UIView {
    
    // MARK: Property
    private let messageTextView = MessageTextView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    var messages  = [Message(text: "მამწერე", date: "11.11.1111"),
                     Message(text: "მამწერე", date: "11.11.1111"),
                     Message(text: "მამწერე", date: "11.11.1111"),
                     Message(text: "მამწერე", date: "11.11.1111")
    ]
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpTableViewConstraints()
        setUpMessageTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: add Subview
    private func setUpView() {
        [tableView, messageTextView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    // MARK: TableView constraint
    private func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageTextView.topAnchor),
        ])
    }
    
    // MARK: MessageView constraint
    private func setUpMessageTextView() {
        NSLayoutConstraint.activate([
            messageTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.InputContainer.leading),
            messageTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.InputContainer.trailing),
            messageTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            messageTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.InputContainer.height),
        ])
    }
}

// MARK: - Extension UITableViewDataSource
extension MessageView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as?  MessageTableViewCell {
            let message = messages[indexPath.row]
            cell.configure(with: message)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}




