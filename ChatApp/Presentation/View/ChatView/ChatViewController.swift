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
    private let topMessageView = MessageView()
    private let bottomMessageView = MessageView()
    private let switchButtonView = SwitchModeView()
    private let viewModel = ChatViewModel()
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
        
        topMessageView.messageTextView.delegate = self
        bottomMessageView.messageTextView.delegate = self
    }
    
    // MARK: StatusBar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle
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
    
    // MARK: Constraints
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
            firstTextField.text = ""
        }
    }
}

// MARK: - SwitchModeViewDelegate
extension ChatViewController: SwitchModeViewDelegate {
    func switchModeView(_ switchModeView: SwitchModeView, didSwitchStateTo state: SwitchModeView.ButtonState) {
        switch state {
        case .light:
            setUpBackgroundColor(with: Constants.SwitchButtonView.backGroundColor)
        case .dark:
            setUpBackgroundColor(with: .white)
            self.statusBarStyle = .darkContent
        }
        setNeedsStatusBarAppearanceUpdate()
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


