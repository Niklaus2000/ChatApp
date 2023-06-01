import UIKit

// MARK: - MessageStyle
enum MessageStyle: String {
     case greeting = "როგორ ხარ?"
     case wellyou = "კარგად, შენ?"
     case fine = "კარგად"
 }

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
        
        messageTextView.delegate = self
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
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        
        let message: MessageStyle = {
            switch indexPath.row {
            case 0: return .greeting
            case 1: return .wellyou
            case 2: return .fine
            default: fatalError("Invalid index path")
            }
        }()
        
        cell.configure(with: message.rawValue, indexpath: indexPath)
        return cell
    }
}

extension MessageView: sendButtonDelegate {
    func sendMessage(textView: String) {
        
    }
}
