//
//  ViewController.swift
//  ChatApp
//
//  Created by MacBoobPro on 18.04.23.
//

import UIKit

class ViewController: UIViewController {

    
    private lazy var stackView = UIStackView(arrangedSubviews: [sendMessageView, receiverMessageView])
    private let sendMessageView = MessageView()
    private let receiverMessageView = MessageView()
    private let switchButtonView = SwitchModeView()
    private let dividerView = DividerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSwitchButtonView()
        setUpStackView()
        switchButtonView.delegate = self
    }
    
    private func setUpStackView() {
        stackView.axis =  .vertical
        stackView.distribution = .fillEqually
    }
    
    private func setUpSwitchButtonView() {
        view.addSubview(switchButtonView)
        view.addSubview(stackView)
        view.addSubview(dividerView)
        
        [switchButtonView, stackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            switchButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            switchButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            switchButtonView.widthAnchor.constraint(equalToConstant: 54),
            switchButtonView.heightAnchor.constraint(equalToConstant: 54),
            stackView.topAnchor.constraint(equalTo: switchButtonView.bottomAnchor),
            dividerView.topAnchor.constraint(equalTo: sendMessageView.bottomAnchor),
            dividerView.bottomAnchor.constraint(equalTo: receiverMessageView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
  
