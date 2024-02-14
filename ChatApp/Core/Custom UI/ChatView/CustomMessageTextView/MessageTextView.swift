//
//  MessageTextView.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 04.05.23.
//

import UIKit

protocol MessageTextViewDelegate: AnyObject {
    func didTapButton(text: String)
}

final class MessageTextView: UIView {
    
    // MARK: Views
    private var heightConstraint: NSLayoutConstraint? = nil
    weak var delegate: MessageTextViewDelegate?
    
    // MARK: Properties
    private lazy var inputContainerView: UIView = {
        let inputContainerView = UIView()
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
        return textView
    }()
    
    private lazy var sendButtonView: UIButton = {
        let sendButton = UIButton()
        sendButton.setImage(Constants.ButtonView.image, for: .normal)
        sendButton.addAction(UIAction(handler: {[weak self] _ in
            self?.didTapSendButton()
        }), for: .touchUpInside)
        return sendButton
    }()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpInputContainerViewConstraints()
        setUpTextViewConstraints()
        setUpButtonViewConstraints()
        updateTextViewHeight()
        addTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    @objc private func didTapSendButton() {
        guard let message = textView.text else { return }
        let processedMessage = message.withoutWhiteSpaces
        if processedMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {return}
        delegate?.didTapButton(text: processedMessage)
        textView.text = ""
    }
    
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
        //view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    
    func setUpTextView(with color: UIColor) {
        textView.textColor = color
    }
    
    // MARK: Add subview
    private func setUp() {
        addSubview(inputContainerView)
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        [textView, sendButtonView].forEach {
            inputContainerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // MARK: Constraint
    private func setUpInputContainerViewConstraints() {
        NSLayoutConstraint.activate([
            inputContainerView.topAnchor.constraint(
                equalTo: topAnchor),
            inputContainerView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.InputContainenrView.leading),
            inputContainerView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            inputContainerView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.InputContainenrView.trailing),
            inputContainerView.heightAnchor.constraint(
                lessThanOrEqualToConstant: Constants.InputContainenrView.height)
        ])
    }
    
    private func setUpTextViewConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(
                equalTo: inputContainerView.topAnchor),
            textView.bottomAnchor.constraint(
                equalTo: inputContainerView.bottomAnchor,
                constant: Constants.TextView.bottom),
            textView.leadingAnchor.constraint(
                equalTo: inputContainerView.leadingAnchor,
                constant: Constants.TextView.leading),
            textView.trailingAnchor.constraint(
                equalTo: sendButtonView.leadingAnchor,
                constant: Constants.TextView.trailing)
        ])
    }
    
    private func setUpButtonViewConstraints() {
        NSLayoutConstraint.activate([
            sendButtonView.bottomAnchor.constraint(
                equalTo: inputContainerView.bottomAnchor,
                constant: Constants.ButtonView.bottom),
            sendButtonView.trailingAnchor.constraint(
                equalTo: inputContainerView.trailingAnchor,
                constant: Constants.ButtonView.trailing),
            sendButtonView.heightAnchor.constraint(
                equalToConstant: Constants.ButtonView.height),
            sendButtonView.widthAnchor.constraint(
                equalToConstant: Constants.ButtonView.width)
        ])
    }
    
    private func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: textView.frame.width, height: CGFloat(Float.infinity))
        let charSize = textView.font?.lineHeight ?? 0
        let text = (textView.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textView.font as Any], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    
    private func updateTextViewHeight() {
        if calculateMaxLines() > Constants.TextView.maxLines {
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
        updateTextViewHeight()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.text == Constants.TextView.text else { return }
        textView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.isEmpty else { return }
        textView.text = Constants.TextView.text
    }
}
