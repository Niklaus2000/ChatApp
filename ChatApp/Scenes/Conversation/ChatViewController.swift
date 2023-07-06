//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 07.06.23.
//

import UIKit

final class ChatViewController: UIViewController, UITextViewDelegate {
    // MARK: Properties
    private lazy var mainStackView = UIStackView(arrangedSubviews: [topMessageView, dividerView, bottomMessageView])
    private let topMessageView: ChatView
    private let bottomMessageView: ChatView
    private let switchButtonView = SwitchModeView()
    private var viewModel: ChatViewModel
    private let dividerView = UIView()
    private var statusBarStyle: UIStatusBarStyle = .darkContent
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpStackView()
        setUpStackViewConstraints()
        setUpSwitchButtonViewConstraints()
        setUpDiverViewConstraints()
        setUpDelegate()
        loadBackgroundColor()
        hideKeyboard()
    }
    
    // MARK: Init
    init() {
        viewModel = ChatViewModel()
        self.topMessageView = ChatView(loggedInUserID: 1, messages: viewModel.getMessages(userID: 1))
        self.bottomMessageView = ChatView(loggedInUserID: 2, messages: viewModel.getMessages(userID: 2))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            $0.delegate = self
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
    
    // MARK: UserDefaults
    private func loadBackgroundColor() {
        if let colorData = UserDefaults.standard.object(forKey: "BackgroundColorKey") as? Data,
           let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
            switchButtonView.isSelected = color == Constants.SwitchButtonView.backGroundColor
            updateAppearance(for: switchButtonView.isSelected)
        }
    }
    
    private func saveBackgroundColor(color: UIColor) {
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) {
            UserDefaults.standard.set(colorData, forKey: "BackgroundColorKey")
        }
    }
    
    private func updateAppearance(for isDarkMode: Bool) {
        let backgroundColor = isDarkMode ? Constants.SwitchButtonView.backGroundColor : .white
        let textColor = isDarkMode ? UIColor.white : UIColor.black
        
        [topMessageView, bottomMessageView, view].forEach { $0.backgroundColor = backgroundColor }
        [topMessageView, bottomMessageView].forEach { $0.setUpTypingComponentView(with: textColor) }
    }
}

// MARK: - SwitchModeViewDelegate
extension ChatViewController: SwitchModeViewDelegate {
    func switchModeView(_ switchModeView: SwitchModeView, didSwitchStateTo state: SwitchModeView.ButtonState) {
        let isDarkMode = state == .dark
        saveBackgroundColor(color: isDarkMode ? Constants.SwitchButtonView.backGroundColor : .white)
        updateAppearance(for: isDarkMode)
    }
}

// MARK: - ChatViewDelegate
extension ChatViewController: ChatViewDelegate {
    func didSendMessage(userID: Int, text: String) {
        viewModel.saveMessage(userID: userID, text: text)
        self.topMessageView.reloadTableView(messages: viewModel.getMessages(userID: 1))
        self.bottomMessageView.reloadTableView(messages: viewModel.getMessages(userID: 2))
    }
}







