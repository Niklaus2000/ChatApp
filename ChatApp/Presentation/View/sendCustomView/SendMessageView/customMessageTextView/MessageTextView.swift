//
//  MessageTextView.swift
//  ChatApp
//
//  Created by MacBoobPro on 04.05.23.
//

import Foundation
import UIKit

final class MessageTextView: UIView {
    private var textViewHeightConstraint: NSLayoutConstraint?
    private var maxlines = 5
    
    private lazy var inputContainerView: UIView = {
        let inputContainerView = UIView()
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        inputContainerView.layer.borderWidth = CGFloat(Constants.borderWith)
        inputContainerView.layer.borderColor = UIColor.lightGray.cgColor
        return inputContainerView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = Constants.textContainerInset
        textView.font = Constants.TextView.textFontSize
        textView.isScrollEnabled = false
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        textView.text = Constants.text
        textView.textColor = UIColor.lightGray
        textView.isScrollEnabled = true
        textView.delegate = self
        textView.textContainer.maximumNumberOfLines = maxlines
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.translatesAutoresizingMaskIntoConstraints  = false
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
        
        addSubview(inputContainerView)
        inputContainerView.addSubview(textView)
        inputContainerView.addSubview(sendButtonView)
        
        setUpInputContainerViewConstraint()
        setUpTextViewConstraint()
        setUpButtonViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpInputContainerViewConstraint() {
        NSLayoutConstraint.activate([
            inputContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(Constants.inputContainerLeadingAnchor)),
            inputContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(Constants.inputContainerTrailingAnchor)),
            inputContainerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
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
extension MessageTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let height = textView.sizeThatFits(size).height
        let maxHeight = CGFloat(Constants.maxLines) * textView.font!.lineHeight
        textViewHeightConstraint?.constant = max(min(height, maxHeight), 44)
        textView.isScrollEnabled = textViewHeightConstraint?.constant ?? 0 >= maxHeight
    }
}

