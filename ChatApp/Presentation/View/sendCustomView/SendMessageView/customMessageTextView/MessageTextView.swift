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
    private lazy var inputContainerView: UIView = {
        let inputContainerView = UIView()
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.layer.cornerRadius = Constants.InputContainenrView.cornerRadius
        inputContainerView.layer.borderWidth = Constants.InputContainenrView.borderWith
        inputContainerView.layer.borderColor = Constants.InputContainenrView.viewBorderUIColor
        return inputContainerView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = Constants.TextView.textContainerInset
        textView.font = Constants.TextView.textFontSize
        textView.isScrollEnabled = false
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        textView.text = Constants.TextView.text
        textView.textColor = .lightGray
        textView.isScrollEnabled = true
        textView.delegate = self
        textView.textContainer.maximumNumberOfLines = Constants.TextView.maxLines
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.translatesAutoresizingMaskIntoConstraints  = false
        return textView
    }()
    
    private lazy var sendButtonView: UIButton = {
        let sendButton = UIButton()
        sendButton.setImage(Constants.ButtonView.image, for: .normal)
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
            inputContainerView.topAnchor.constraint(equalTo: topAnchor),
            inputContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.InputContainenrView.inputContainerLeadingAnchor),
            inputContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            inputContainerView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: Constants.InputContainenrView.inputContainerTrailingAnchor)
            ])
    }
    
    private func  setUpTextViewConstraint() {
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: Constants.TextView.textViewHeightConstraint)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: Constants.TextView.textViewTopAnchor),
            textView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: Constants.TextView.textViewLeadingAnchor),
            textView.trailingAnchor.constraint(equalTo: sendButtonView.leadingAnchor, constant: Constants.TextView.textViewTrailingAnchor),
            textViewHeightConstraint!,
        ])
    }
    
    private func  setUpButtonViewConstraint() {
        NSLayoutConstraint.activate([
            sendButtonView.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: Constants.ButtonView.sendButtonViewTrailingAnchor),
            sendButtonView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: Constants.ButtonView.sendButtonViewBottomAnchor),
            sendButtonView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.ButtonView.sendButtonViewWidthAnchor)),
            sendButtonView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.ButtonView.sendButtonViewHeightAnchor))
        ])
    }
}

extension MessageTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let height = textView.sizeThatFits(size).height
        let maxHeight = CGFloat(Constants.TextView.maxLines) * textView.font!.lineHeight
        textViewHeightConstraint?.constant = max(min(height, maxHeight), Constants.TextView.textViewHeightConstraint)
        textView.isScrollEnabled = textViewHeightConstraint?.constant ?? 0 >= maxHeight
        
        textView.text = textView.text.isEmpty ? "დაწერე შეტობინენბა" : textView.text
        textView.textColor = textView.text.isEmpty ? UIColor.lightGray : UIColor.black
        textView.text = textView.text.isEmpty ? "დაწერე შეტობინენბა" : textView.text
        textView.textColor = textView.text == "დაწერე შეტობინენბა" ? UIColor.lightGray : UIColor.black
    }
}

