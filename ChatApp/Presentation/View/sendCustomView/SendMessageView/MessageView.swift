import UIKit

class MessageView: UIView {
    private var textViewHeightConstraint: NSLayoutConstraint?
    private let maxLines = 5
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints =  false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var inputContainerView: UIView = {
        let inputContainerView = UIView()
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        inputContainerView.layer.borderWidth = CGFloat(Constants.borderWith)
        inputContainerView.layer.borderColor = UIColor.lightGray.cgColor
        return inputContainerView
    }()
    
    private lazy var containerTableView: UIView = {
        let containerTableView = UIView()
        containerTableView.translatesAutoresizingMaskIntoConstraints = false
        return containerTableView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = Constants.textContainerInset
        textView.font = Constants.textFontSize
        textView.isScrollEnabled = false
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        textView.text = Constants.text
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = true
        textView.textContainer.maximumNumberOfLines = maxLines
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var sendButtonView: UIButton = {
        let sendButton = UIButton()
        sendButton.setImage(Constants.image, for: .normal)
        // sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        return sendButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerTableView)
        containerTableView.addSubview(tableView)
        addSubview(inputContainerView)
        inputContainerView.addSubview(textView)
        inputContainerView.addSubview(sendButtonView)
        
        // setUpContainerTableViewConstraint()
        setUpTableViewConstraint()
        
        setUpInputContainerViewConstraint()
        setUpTextViewConstraint()
        setUpButtonViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    private func setUpContainerTableViewConstraint() {
    //        NSLayoutConstraint.activate([
    //            containerTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
    //            containerTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
    //            containerTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    //            containerTableView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
    //        ])
    //    }
    
    private func setUpTableViewConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
        ])
    }
    
    private func setUpInputContainerViewConstraint() {
        NSLayoutConstraint.activate([
            inputContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:CGFloat(Constants.inputContainerLeadingAnchor)),
            inputContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(Constants.inputContainerTrailingAnchor)),
            inputContainerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            inputContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(Constants.inputContainerHeightAnchor)),
        ])
    }
    
    private func  setUpTextViewConstraint() {
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 44)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 22),
            textView.trailingAnchor.constraint(equalTo: sendButtonView.leadingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            textViewHeightConstraint!,
        ])
    }
    
    private func  setUpButtonViewConstraint() {
        NSLayoutConstraint.activate([
            sendButtonView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 10),
            sendButtonView.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -10),
            sendButtonView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -10),
            sendButtonView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.sendButtonViewWidthAnchor))
        ])
    }
    
}

extension MessageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        return cell
    }
}

extension MessageView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let height = textView.sizeThatFits(size).height
        textViewHeightConstraint?.constant = max(min(height, CGFloat(maxLines) * textView.font!.lineHeight), 44)
        textView.isScrollEnabled = textViewHeightConstraint?.constant ?? 0 >= CGFloat(maxLines) * textView.font!.lineHeight
    }
}


