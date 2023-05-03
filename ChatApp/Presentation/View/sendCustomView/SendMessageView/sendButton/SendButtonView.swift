////
////  SendButton.swift
////  ChatApp
////
////  Created by MacBoobPro on 02.05.23.
////
//
//import Foundation
//import UIKit
//
//class SendButtonView: UIView {
//    private lazy var sendButtonView: UIButton = {
//        let sendButton = UIButton()
//        sendButton.setImage(Constants.image, for: .normal)
//        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
//        sendButton.translatesAutoresizingMaskIntoConstraints = false
//        return sendButton
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//       // setUpConstraints()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    private func setUpConstraints() {
//        sendButtonView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 10),
//        sendButtonView.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -10),
//        sendButtonView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -10),
//        sendButtonView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.sendButtonViewWidthAnchor))
//    }
//
//    @objc private func sendButtonTapped() {
//        guard let text = textView.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
//            return
//        }
//        textView.text = "Enter your message"
//        textView.resignFirstResponder()
//        textViewHeightConstraint?.constant = 44
//    }
//}
