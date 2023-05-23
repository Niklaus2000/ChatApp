import UIKit

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
    
    // MARK: Constraint
    private func setUpTableViewConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.top),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leading),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.trailing),
        ])
    }
    
    private func setUpMessageTextView(){
        NSLayoutConstraint.activate([
            messageTextView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            messageTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageTextView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
}

// MARK: - Extension UITableViewDataSource
extension MessageView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        if indexPath.row == 0 {
            cell.configure(with: "როგორ ხარ?", indexpath: indexPath)
        } else if indexPath.row == 1 {
            cell.configure(with: "კარგად, შენ?", indexpath: indexPath)
        }else if indexPath.row == 2 {
            cell.configure(with: "კარგად", indexpath: indexPath)
        }
       return cell
        
       }
}




