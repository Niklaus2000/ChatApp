//
//  DividerView.swift
//  ChatApp
//
//  Created by MacBoobPro on 30.04.23.
//

import UIKit

class DividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                topAnchor.constraint(equalTo: superview.topAnchor),
                bottomAnchor.constraint(equalTo: superview.topAnchor, constant: CGFloat(Constants.bottomAnchor) ),
                widthAnchor.constraint(equalTo: superview.widthAnchor)
            ])
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(cod er:) has not been implemented")
    }
}
extension DividerView {
    enum Constants {
        static let bottomAnchor = 30
    }
}
