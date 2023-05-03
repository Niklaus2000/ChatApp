//
//  ViewController.swift
//  ChatApp
//
//  Created by MacBoobPro on 18.04.23.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var stackView = UIStackView(arrangedSubviews: [sendMessageView, receiverMessageView])
    private lazy var sendMessageView = MessageView()
    private let receiverMessageView = MessageView()
    private let switchButtonView = SwitchModeView()
    private let dividerView = DividerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setUpStackView()
        setUpStackViewConstraint()
        setUpSwitchButtonViewConstraint()
        setUpDiverViewConstraint()
        switchButtonView.delegate = self
        
    }
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    private func setUpStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
    }
    
    private func addSubview() {
        [dividerView, switchButtonView, stackView, dividerView].forEach { view in
            self.view.addSubview(view)
        }
        [switchButtonView, stackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setUpSwitchButtonViewConstraint() {
        NSLayoutConstraint.activate([
            switchButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(Constants.switchButtontopAnchor)),
            switchButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: CGFloat(Constants.switchButtontTrailingAnchor)),
            switchButtonView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.switchButtontWidthAnchor)),
            switchButtonView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.switchButtontHHeightAnchor)),
        ])
    }
    
    private func setUpStackViewConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: switchButtonView.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setUpDiverViewConstraint() {
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: sendMessageView.bottomAnchor),
            dividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dividerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
}

extension ViewController: SwitchModeViewDelegate {
    func switchModeView(with state: ButtonState) {
        switch state {
        case .light:
            self.sendMessageView.backgroundColor = .white
            self.receiverMessageView.backgroundColor = .white
        case .dark:
            self.sendMessageView.backgroundColor = .blue
            self.receiverMessageView.backgroundColor = .blue
        }
    }
}


