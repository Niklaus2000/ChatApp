import UIKit

class MessageView: UIView {
    
    private var textViewHeightConstraint: NSLayoutConstraint?
    private var inputContainerBottomConstraint: NSLayoutConstraint?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints =  false
        return tableView
    }()
    
    private lazy var inputContainerView: UIView = {
        let inputContainerView = UIView()
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.layer.cornerRadius = 20
        inputContainerView.layer.borderWidth = 1
        inputContainerView.layer.borderColor = UIColor.lightGray.cgColor
        return inputContainerView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.textAlignment = .left
        textView.text = "Enter your message"
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints  = false
//        textView.delegate = self
        return textView
    }()
    
    private lazy var sendButtonView: UIButton = {
        let sendButton = UIButton()
        sendButton.setImage(UIImage(named: "send_button_image"), for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        return sendButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        self.backgroundColor = .white
        
        addSubview(tableView)
        addSubview(inputContainerView)
        inputContainerView.addSubview(textView)
        inputContainerView.addSubview(sendButtonView)
        
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 44)
        inputContainerBottomConstraint = inputContainerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
            
            inputContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            inputContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            inputContainerBottomConstraint!,
            inputContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            textView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: sendButtonView.leadingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -10),
            textViewHeightConstraint!,
            
            sendButtonView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 10),
            sendButtonView.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -10),
            sendButtonView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -10),
            sendButtonView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func sendButtonTapped() {
        guard let text = textView.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        // handle sending message
        textView.text = "Enter your message"
        textView.resignFirstResponder()
        textViewHeightConstraint?.constant = 44
    }
}
