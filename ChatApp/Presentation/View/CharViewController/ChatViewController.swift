//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 18.04.23.
//

import UIKit

final class ChatViewController: UIViewController {
    
    // MARK: Properties
    private lazy var mainStackView = UIStackView(arrangedSubviews: [topMessageView, dividerView, bottomMessageView])
    let topMessageView = ChatView()
    private let bottomMessageView = ChatView()
    private let switchButtonView = SwitchModeView()
    private let viewModel = ChatViewModel()
    private let dividerView = UIView()
    private let state: SwitchModeView.ButtonState = .light
    private var statusBarStyle: UIStatusBarStyle = .darkContent
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setUpStackView()
        setUpStackViewConstraints()
        setUpSwitchButtonViewConstraints()
        setUpDiverViewConstraints()
        viewModel.fetchMessage()
        
        topMessageView.messageTextView.delegate = self
        bottomMessageView.messageTextView.delegate = self
        topMessageView.tableView.dataSource = self
        bottomMessageView.tableView.dataSource = self
        
        topMessageView.tableView.delegate = self
        bottomMessageView.tableView.delegate = self
        
        viewModel.reloadTableView = { [weak self] in
            self?.topMessageView.tableView.reloadData()
            self?.bottomMessageView.tableView.reloadData()
        }
        
        if let colorData = UserDefaults.standard.object(forKey: "BackgroundColorKey") as? Data {
            if let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
                setUpBackgroundColor(with: color)
            }
        }
        
    }
    
    // MARK: StatusBar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    // MARK: StackView
    private func setUpStackView() {
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
    }
    
    // MARK: Add subView
    private func setUp() {
        [
            switchButtonView,
            mainStackView,
            dividerView].forEach {
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    // MARK: Constraint
    private func setUpSwitchButtonViewConstraints() {
        switchButtonView.delegate = self
        NSLayoutConstraint.activate([
            switchButtonView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.SwitchButtonView.top),
            switchButtonView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: Constants.SwitchButtonView.trailing),
            switchButtonView.widthAnchor.constraint(
                equalToConstant: Constants.SwitchButtonView.width),
            switchButtonView.heightAnchor.constraint(
                equalToConstant: Constants.SwitchButtonView.height),
        ])
    }
    
    private func setUpStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(
                equalTo: switchButtonView.bottomAnchor),
            mainStackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: Constants.StackView.bottom),
            mainStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
        ])
    }
    
    private func setUpDiverViewConstraints() {
        dividerView.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(
                equalTo: topMessageView.bottomAnchor,
                constant: Constants.DivederView.top),
            dividerView.bottomAnchor.constraint(
                equalTo: bottomMessageView.topAnchor,
                constant: Constants.DivederView.bottom),
            dividerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(
                equalToConstant: Constants.DivederView.height)
        ])
    }
}

// MARK: - SwitchModeViewDelegate
extension ChatViewController: SwitchModeViewDelegate {
    func switchModeView(_ switchModeView: SwitchModeView, didSwitchStateTo state: SwitchModeView.ButtonState) {
        switch state {
        case .light:
            saveBackgroundColor(color: Constants.SwitchButtonView.backGroundColor)
            setUpBackgroundColor(with: Constants.SwitchButtonView.backGroundColor)
            self.statusBarStyle = .lightContent
        case .dark:
            saveBackgroundColor(color: .white)
            setUpBackgroundColor(with: .white)
            self.statusBarStyle = .darkContent
        }
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    private func saveBackgroundColor(color: UIColor) {
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) {
            UserDefaults.standard.set(colorData, forKey: "BackgroundColorKey")
        }
    }
    
    private func setUpBackgroundColor(with color: UIColor) {
        [
            topMessageView,
            bottomMessageView,
            view].forEach {
                $0.backgroundColor = color
            }
    }
}

extension ChatViewController: sendButtonDelegate {
    func sendMessage() {
        let firstTextField = topMessageView.messageTextView.textView
        let secondTextField = bottomMessageView.messageTextView.textView
        
        if firstTextField.isFirstResponder {
            guard let text = firstTextField.text else { return }
            viewModel.createMessage(id: 1, text: text)
            firstTextField.text = ""
        } else if secondTextField.isFirstResponder {
            guard let text = secondTextField.text else { return }
            viewModel.createMessage(id: 2, text: text)
            secondTextField.text = ""
        }
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        let message  = viewModel.messages[indexPath.row]
        
        switch state  {
        case .light:
            if tableView == topMessageView.tableView {
                switch message.userId {
                case 1:
                    cell.configure(with: message, bublePosition: message.userId == 1 ? .right: .left)
                case 2:
                    cell.configure(with: message, bublePosition: message.userId == 2 ? .left: .right)
                default:
                    return UITableViewCell()
                }
            } else if tableView ==  bottomMessageView.tableView {
                switch message.userId {
                case 1:
                    cell.configure(with: message, bublePosition: message.userId == 1 ? .left: .right)
                case 2:
                    cell.configure(with: message, bublePosition: message.userId == 2 ? .right: .left)
                default:
                    return UITableViewCell()
                }
            }
            
        case .dark:
            if tableView == topMessageView.tableView {
                switch message.userId {
                case 1:
                    cell.configure(with: message, bublePosition: message.userId == 1 ? .right: .left)
                case 2:
                    cell.configure(with: message, bublePosition: message.userId == 2 ? .left: .right)
                default:
                    return UITableViewCell()
                }
            } else if tableView ==  bottomMessageView.tableView {
                switch message.userId {
                case 1:
                    cell.configure(with: message, bublePosition: message.userId == 1 ? .left: .right)
                case 2:
                    cell.configure(with: message, bublePosition: message.userId == 2 ? .right: .left)
                default:
                    return UITableViewCell()
                }
            }
        }
        return cell
    }
}



