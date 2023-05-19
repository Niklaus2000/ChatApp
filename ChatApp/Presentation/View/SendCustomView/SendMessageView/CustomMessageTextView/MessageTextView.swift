//
//  MessageTextView.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 04.05.23.
//

import UIKit

final class MessageTextView: UIView {
    
    // MARK: Variable
    private var textViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: Properties
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
        textView.backgroundColor = .clear
        textView.text = Constants.TextView.text
        textView.textColor = Constants.TextView.placeholderColor
        textView.delegate = self
        textView.textContainer.maximumNumberOfLines = Constants.TextView.maxLines
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.translatesAutoresizingMaskIntoConstraints  = false
        return textView
    }()
    
    private lazy var sendButtonView: UIButton = {
        let sendButton = UIButton()
        sendButton.setImage(Constants.ButtonView.image, for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        return sendButton
    }()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpInputContainerViewConstraint()
        setUpTextViewConstraint()
        setUpButtonViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Add subView
    private func setUpView() {
        addSubview(inputContainerView)
        inputContainerView.addSubview(textView)
        inputContainerView.addSubview(sendButtonView)
    }
    
    // MARK: ContainerView constraint
    private func setUpInputContainerViewConstraint() {
        NSLayoutConstraint.activate([
            inputContainerView.topAnchor.constraint(equalTo: topAnchor),
            inputContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.InputContainenrView.leading),
            inputContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            inputContainerView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: Constants.InputContainenrView.trailing)
        ])
    }
    
    // MARK: TextView constraint
    private func  setUpTextViewConstraint() {
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: Constants.TextView.height)
        textViewHeightConstraint?.isActive = true
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: Constants.TextView.top),
            textView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: Constants.TextView.leading),
            textView.trailingAnchor.constraint(equalTo: sendButtonView.leadingAnchor, constant: Constants.TextView.trailing),
            textViewHeightConstraint!,
        ])
    }
    
    // MARK: ButtonView constraint
    private func  setUpButtonViewConstraint() {
        NSLayoutConstraint.activate([
            sendButtonView.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: Constants.ButtonView.trailing),
            sendButtonView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: Constants.ButtonView.bottom),
            sendButtonView.widthAnchor.constraint(equalToConstant: Constants.ButtonView.width),
            sendButtonView.heightAnchor.constraint(equalToConstant: Constants.ButtonView.height)
        ])
    }
}

// MARK: - UITextViewDelegate
extension MessageTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let height = textView.sizeThatFits(size).height
        let maxHeight = CGFloat(Constants.TextView.maxLines) * (textView.font?.lineHeight ?? 0)
        textViewHeightConstraint?.constant = max(min(height, maxHeight), Constants.TextView.height)
        textView.isScrollEnabled = textViewHeightConstraint?.constant ?? 0 >= maxHeight
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.text.isEmpty == false else {
            return
        }
        textView.text = ""
        textView.textColor = Constants.TextView.lightModeTextColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.isEmpty else {
            return
        }
        textView.text = Constants.TextView.text
        textView.textColor  = .white
    }
}

