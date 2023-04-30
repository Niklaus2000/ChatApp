//
//  SwitchModeView.swift
//  ChatApp
//
//  Created by MacBoobPro on 27.04.23.
//

import Foundation
import UIKit

enum ButtonState {
    case dark
    case light
}

protocol SwitchModeViewDelegate: AnyObject {
    func switchModeView(with state: ButtonState)
}

class SwitchModeView: UIButton {
    
    weak var delegate: SwitchModeViewDelegate?
    var buttonState: ButtonState = .light
    
    private lazy var switchMode: UIButton = {
        let switchButton = UIButton(type: .custom)
        switchButton.setImage(UIImage(named: LocalConstants.switchLightImage), for: .normal)
        switchButton.setImage(UIImage(named: LocalConstants.switchDarkImage), for: .selected)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        return switchButton
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraint() {
        addSubview(switchMode)
        NSLayoutConstraint.activate([
            switchMode.widthAnchor.constraint(equalTo: widthAnchor),
            switchMode.heightAnchor.constraint(equalTo: heightAnchor),
            switchMode.centerXAnchor.constraint(equalTo: centerXAnchor),
            switchMode.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        switchMode.addTarget(self, action: #selector(switchModeTapped), for: .touchUpInside)
    }
    
    @objc private func switchModeTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        buttonState = sender.isSelected ? .light : .dark
        switch buttonState {
        case .dark:
            delegate?.switchModeView(with: .dark)
        case .light:
            delegate?.switchModeView(with: .light)
        }
        
    }
}
