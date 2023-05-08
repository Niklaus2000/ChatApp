//
//  ViewController.swift
//  ChatApp
//
//  Created by MacBoobPro on 18.04.23.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    private lazy var stackView = UIStackView(arrangedSubviews: [topMessageView, dividerView, bottomMessageView])
    private lazy var topMessageView = MessageView()
    private let bottomMessageView = MessageView()
    private let switchButtonView = SwitchModeView()
    private lazy var dividerView = UIView()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setUpStackView()
        setUpStackViewConstraint()
        setUpSwitchButtonViewConstraint()
        setUpDiverViewConstraint()
        switchButtonView.delegate = self
        dividerView.backgroundColor = .yellow
    }
    
    //MARK: StackView
    private func setUpStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
    }
    
    //MARK: Add subView
    private func addSubview() {
        [dividerView, switchButtonView, stackView].forEach { view in
            self.view.addSubview(view)
        }
        [dividerView, switchButtonView, stackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
   
    }
    
    //MARK: SwitchButtonView Constraint
    private func setUpSwitchButtonViewConstraint() {
        NSLayoutConstraint.activate([
            switchButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.switchButtontopAnchor),
            switchButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.switchButtontTrailingAnchor),
            switchButtonView.widthAnchor.constraint(equalToConstant: Constants.switchButtontWidthAnchor),
            switchButtonView.heightAnchor.constraint(equalToConstant: Constants.switchButtontHHeightAnchor),
        ])
    }
    
    //MARK: StackView Constraint
    private func setUpStackViewConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: switchButtonView.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    //MARK: DivederView Constraint
    private func setUpDiverViewConstraint() {
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: topMessageView.bottomAnchor, constant: 30),
            dividerView.bottomAnchor.constraint(equalTo: bottomMessageView.topAnchor),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: Constants.dividerViewHeightAnchor)
        ])
    }
}

//MARK: Extension
extension ViewController: SwitchModeViewDelegate {
    func switchModeView(with state: ButtonState) {
        topMessageView.backgroundColor = state == .dark ? .white : Constants.backGroundColor
        bottomMessageView.backgroundColor = state == .dark ? .white : Constants.backGroundColor
        view.backgroundColor = state == .dark ? .white : Constants.backGroundColor
    }
}


