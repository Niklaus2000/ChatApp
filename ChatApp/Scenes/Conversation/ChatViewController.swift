//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 07.06.23.
//

import UIKit

struct User {
    var userId: Int
    let text: String?
    var date: String?

//    init(message: Message) {
//        userId = Int(message.userId)
//        text = message.text ?? ""
//        date = message.date ?? ""
//    }
}

final class ChatViewController: UIViewController, UITextViewDelegate {
    // MARK: Properties
    private lazy var mainStackView = UIStackView(arrangedSubviews: [topMessageView, dividerView, bottomMessageView])
    private let topMessageView = ChatView()
    private let bottomMessageView = ChatView()
    private let switchButtonView = SwitchModeView()
    private let viewModel = ChatViewModel()
    private let dividerView = UIView()
    private let network = NetworkManager()
    private var statusBarStyle: UIStatusBarStyle = .darkContent
    
    private var messages: [User] = []
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setUpStackView()
        setUpStackViewConstraints()
        setUpSwitchButtonViewConstraints()
        setUpDiverViewConstraints()
        viewModel.fetchMessage()
        saveBackGroundColor()
        setUpDelegate()
    }
    
    // MARK: UserDefault
    private func saveBackGroundColor() {
        if let colorData = UserDefaults.standard.object(forKey: "BackgroundColorKey") as? Data,
           let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
            setUpBackgroundColor(with: color)
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
    
    // MARK: Set UP Delegate
    private func setUpDelegate() {
        [topMessageView, bottomMessageView].forEach {
            $0.delegate  = self
            $0.configTableView(dataSource: self, delegate: self)
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
            setUpBackgroundColor(with: Constants.SwitchButtonView.backGroundColor)
            saveBackgroundColor(color: Constants.SwitchButtonView.backGroundColor)
            self.statusBarStyle = .lightContent
        case .dark:
            setUpBackgroundColor(with: .white)
            saveBackgroundColor(color: .white)
            self.statusBarStyle = .darkContent
        }
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setUpBackgroundColor(with color: UIColor) {
        [
            topMessageView,
            bottomMessageView,
            view].forEach {
                $0.backgroundColor = color
            }
    }
    
    private func saveBackgroundColor(color: UIColor) {
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) {
            UserDefaults.standard.set(colorData, forKey: "BackgroundColorKey")
        }
    }
}
/// MARK:  - Romlitac vmuSaob
// MARK: -  ChatViewDelegate
//extension ChatViewController: ChatViewDelegate {
//    func didSendMessage(chatView: ChatView, text: String, date: Date, userId: Int) {
//        if chatView === topMessageView {
//            configureTableView(id: 1, text: text, isTop: true)
//        } else if chatView === bottomMessageView {
//            configureTableView(id: 2, text: text, isTop: false)
//        }
//    }
//
////    private func configureTableView(id: Int, text: String, isTop: Bool) {
////        let isSent = !network.isInternetAvailable()
////        viewModel.createMessage(id: id, text: text, isSent: isSent) { [weak self] in
////            self?.reloadAppropriateTableViews(isSent: isSent, isTop: isTop)
////            //self?.bottomMessageView.reloadTableView()
////            //self?.topMessageView.reloadTableView()
////        }
////    }
//    private func configureTableView(id: Int, text: String, isTop: Bool) {
//        let isSent = !network.isInternetAvailable()
//        viewModel.createMessage(id: id, text: text, isSent: isSent) { [weak self] in
//            self?.reloadAppropriateTableViews(isSent: isSent, isTop: isTop)
//            if isSent && isTop {
//                let newMessage = User(userId: id, text: text, date: Date().description)
//                self?.messages.insert(newMessage, at: 0)
//                self?.topMessageView.reloadTableView()
//            }
//        }
//    }
//
//
//    private func reloadAppropriateTableViews(isSent: Bool, isTop: Bool) {
//        if isSent {
//            topMessageView.reloadTableView()
//        } else {
//            topMessageView.reloadTableView()
//            bottomMessageView.reloadTableView()
//        }
//        if !isTop {
//            bottomMessageView.reloadTableView()
//        }
//    }
//}
// =======================================
//extension ChatViewController: ChatViewDelegate {
//    func didSendMessage(chatView: ChatView, text: String, date: Date, userId: Int) {
//        if chatView === topMessageView {
//            configureTableView(id: 1, text: text, isTop: true)
//        } else if chatView === bottomMessageView {
//            configureTableView(id: 2, text: text, isTop: false)
//        }
//    }
//
//    private func configureTableView(id: Int, text: String, isTop: Bool) {
//        let isSent = !network.isInternetAvailable()
//
//        viewModel.createMessage(id: id, text: text, isSent: isSent) { [weak self] in
//            self?.reloadAppropriateTableViews(isSent: isSent, isTop: isTop)
//
//            if isSent && isTop {
//                let newMessage = User(userId: id, text: text, date: Date().description)
//                self?.messages.insert(newMessage, at: 0)
//                self?.topMessageView.reloadTableView()
//            }
//        }
//    }
//
//    private func reloadAppropriateTableViews(isSent: Bool, isTop: Bool) {
//        if isSent {
//            topMessageView.reloadTableView()
//
//            if !isTop {
//                bottomMessageView.reloadTableView()
//            }
//        } else {
//            topMessageView.reloadTableView()
//            bottomMessageView.reloadTableView()
//        }
//    }
//}
//
//
//// MARK: - UITableViewDataSource
//extension ChatViewController: UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.messages.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
//        let message = viewModel.messages[indexPath.row]
//
//        cell.configure(with: message, bublePosition: ((tableView == topMessageView.getTableView()) == (message.userId == 1)) ? .right : .left)
//
//        return cell
//    }
//}
// ==============================================================
extension ChatViewController: ChatViewDelegate {
       func didSendMessage(chatView: ChatView, text: String, date: Date, userId: Int) {
           if chatView === topMessageView {
               configureTableView(id: 1, text: text, isTop: true)
           } else if chatView === bottomMessageView {
               configureTableView(id: 2, text: text, isTop: false)
           }
       }

    private func configureTableView(id: Int, text: String, isTop: Bool) {
            let isSent = network.isInternetAvailable()
            viewModel.createMessage(id: id, text: text, isSent: isSent) { [weak self] in
                guard let self = self else { return }
                let newMessage = User(userId: id, text: text, date: Date().description)
                if isSent && isTop {
                    self.messages.insert(newMessage, at: 0)
                    self.topMessageView.reloadTableView()
                } else if isSent && !isTop {
                    self.messages.append(newMessage)
                    self.topMessageView.reloadTableView()
                }
            }
        }
    
//    private func configureTableView(id: Int, text: String, isTop: Bool) {
//        let isSent = network.isInternetAvailable()
//        viewModel.createMessage(id: id, text: text, isSent: isSent) { [weak self] in
//            guard let self = self else { return }
//            let newMessage = User(userId: id, text: text, date: Date().description)
//
//            if isSent && isTop {
//                self.messages = self.messages.filter { $0.userId != id }
//                self.messages.insert(newMessage, at: 0)
//                self.topMessageView.reloadTableView()
//            } else if isSent && !isTop {
//                self.messages = self.messages.filter { $0.userId != id }
//                self.messages.append(newMessage)
//                self.bottomMessageView.reloadTableView()
//            } else if !isSent && isTop {
//                self.messages = self.messages.filter { $0.userId != id }
//                self.messages.append(newMessage)
//                self.topMessageView.reloadTableView()
//            } else if !isSent && !isTop {
//                self.messages = self.messages.filter { $0.userId != id }
//                self.messages.insert(newMessage, at: 0)
//                self.bottomMessageView.reloadTableView()
//            }
//        }
//    }


   }

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        let message = viewModel.messages[indexPath.row]

        cell.configure(with: message, bublePosition: ((tableView == topMessageView.getTableView()) == (message.userId == 1)) ? .right : .left)

        return cell
    }
}
///====================================





// MARK: - UITableViewDataSource
//extension ChatViewController: UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.messages.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
//        let message = viewModel.messages[indexPath.row]
//
//        cell.configure(with: message, bublePosition: ((tableView == topMessageView.getTableView()) == (message.userId == 1)) ? .right : .left)
//
//        return cell
//    }
//}


//======================================

//extension ChatViewController: ChatViewDelegate {
//    func didSendMessage(chatView: ChatView, text: String, date: Date, userId: Int) {
//        if chatView === topMessageView {
//            configureTableView(id: 1, text: text, isTop: true)
//        } else if chatView === bottomMessageView {
//            configureTableView(id: 2, text: text, isTop: false)
//        }
//    }
//
//    private func configureTableView(id: Int, text: String, isTop: Bool) {
//        let isSent = !network.isInternetAvailable()
//        viewModel.createMessage(id: id, text: text, isSent: isSent) { [weak self] in
//            self?.reloadAppropriateTableViews(isSent: isSent, isTop: isTop)
//        }
//    }
//
//    private func reloadAppropriateTableViews(isSent: Bool, isTop: Bool) {
//        if isSent && isTop {
//            topMessageView.reloadTableView()
//        } else if isSent && !isTop {
//            bottomMessageView.reloadTableView()
//        }
//    }
//}
//
//
//// MARK: - UITableViewDataSource
//extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == topMessageView.getTableView() {
//            return viewModel.messages.filter { $0.userId == 1 }.count
//        } else if tableView == bottomMessageView.getTableView() {
//            return viewModel.messages.filter { $0.userId != 1 }.count
//        }
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
//
//        if tableView == topMessageView.getTableView() {
//            let topMessages = viewModel.messages.filter { $0.userId == 1 }
//            let message = topMessages[indexPath.row]
//            cell.configure(with: message, bublePosition: .right)
//        } else if tableView == bottomMessageView.getTableView() {
//            let bottomMessages = viewModel.messages.filter { $0.userId != 1 }
//            let message = bottomMessages[indexPath.row]
//            cell.configure(with: message, bublePosition: .left)
//        }
//
//        return cell
//    }
//}
//
//
//
//
