import UIKit


enum ButtonState {
    case light
    case dark
}

protocol SwitchModeViewDelegate: AnyObject {
    func switchModeView(with state: ButtonState)
}

class SwitchModeView: UIButton {
    
    weak var delegate: SwitchModeViewDelegate?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraint() {
        setImage(UIImage(named: LocalConstants.switchDarkImage), for: .selected)
        setImage(UIImage(named: LocalConstants.switchLightImage), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(switchModeTapped), for: .touchUpInside)
    }
    
    @objc private func switchModeTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.isSelected
        ? delegate?.switchModeView(with: .light)
        : delegate?.switchModeView(with: .dark)
    }
}
