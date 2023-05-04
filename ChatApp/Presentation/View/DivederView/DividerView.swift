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
    }
    required init?(coder: NSCoder) {
        fatalError("init(cod er:) has not been implemented")
    }
}
