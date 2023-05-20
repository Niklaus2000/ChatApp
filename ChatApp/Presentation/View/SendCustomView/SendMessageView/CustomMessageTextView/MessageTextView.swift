//
//  MessageTextView.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 04.05.23.
//

import UIKit

final class MessageTextView: UIView {
    
    // MARK: Variable
    private var heightConstraint: NSLayoutConstraint? = nil
    private var heightFor5Lines: CGFloat = 0
    
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
        textView.isScrollEnabled = false
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
        setUpInputContainerViewConstraints()
        setUpTextViewConstraints()
        setUpButtonViewConstraints()
        updateTextViewHeight()
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
    
    // MARK: Constraint
    private func setUpInputContainerViewConstraints() {
        NSLayoutConstraint.activate([
            inputContainerView.topAnchor.constraint(equalTo: topAnchor),
            inputContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.InputContainenrView.leading),
            inputContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            inputContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.InputContainenrView.trailing),
            inputContainerView.heightAnchor.constraint(lessThanOrEqualToConstant: Constants.InputContainenrView.height)
        ])
    }
    
    private func setUpTextViewConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: inputContainerView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: Constants.TextView.bottom),
            textView.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: Constants.TextView.leading),
            textView.trailingAnchor.constraint(equalTo: sendButtonView.leadingAnchor, constant: Constants.TextView.trailing)
        ])
    }
    
    private func setUpButtonViewConstraints() {
        NSLayoutConstraint.activate([
            sendButtonView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: Constants.ButtonView.bottom),
            sendButtonView.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: Constants.ButtonView.trailing),
        ])
    }
    
    // MARK: TextView Func
    private func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: textView.frame.width, height: CGFloat(Float.infinity))
        let font = textView.font ?? Constants.TextView.textFontSize
        let charSize = font.lineHeight
        let text = (textView.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }

    private func updateTextViewHeight() {
        if calculateMaxLines() > 5 {
            if heightConstraint != nil { return }
            heightConstraint = inputContainerView.heightAnchor.constraint(equalToConstant: inputContainerView.frame.height)
            heightConstraint?.isActive = true
            textView.isScrollEnabled = true
        } else {
            textView.isScrollEnabled = false

            if let heightConstraint {
                heightConstraint.isActive = false
                inputContainerView.removeConstraint(heightConstraint)
                inputContainerView.layoutIfNeeded()
                textView.layoutIfNeeded()
                layoutIfNeeded()
            }
            heightConstraint = nil
        }
    }
}

// MARK: - UITextViewDelegate
extension MessageTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateTextViewHeight()
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

