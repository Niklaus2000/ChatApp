import UIKit

//MARK: ENUM State
enum ButtonState {
    case light
    case dark
}

//MARK: Switch Protocol
protocol SwitchModeViewDelegate: AnyObject {
    func switchModeView(with state: ButtonState)
}

final class SwitchModeView: UIButton {
    weak var delegate: SwitchModeViewDelegate?
    
    //MARK: Init
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Constraint
    private func setUpConstraint() {
        setImage(LocalConstants.switchLightImage, for: .normal)
        setImage(LocalConstants.switchDarkImage, for: .selected)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(switchModeTapped), for: .touchUpInside)
    }
    
    //MARK: SwitchMode
    @objc private func switchModeTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.isSelected
        ? delegate?.switchModeView(with: .light)
        : delegate?.switchModeView(with: .dark)
    }
}
