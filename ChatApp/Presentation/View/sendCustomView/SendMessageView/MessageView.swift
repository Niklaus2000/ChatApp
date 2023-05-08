import UIKit

final class MessageView: UIView {
    //MARK: Property
    private lazy var messageTextView = MessageTextView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints =  false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        addSubview(messageTextView)
       
        setUpTableViewConstraint()
        setUpmessageTextView()
        messageTextView.translatesAutoresizingMaskIntoConstraints =  false

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: TableView constraint
    private func setUpTableViewConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageTextView.topAnchor),
        ])
    }
    
    //MARK: MessageView constraint
    private func setUpmessageTextView() {
        NSLayoutConstraint.activate([
            messageTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.inputContainerLeadingAnchor),
            messageTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.inputContainerTrailingAnchor),
            messageTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            messageTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.inputContainerHeightAnchor),
        ])
    }
}

//MARK: Extension tableView
extension MessageView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
}



