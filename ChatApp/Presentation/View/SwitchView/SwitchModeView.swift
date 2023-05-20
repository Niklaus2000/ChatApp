import UIKit

// MARK: Switch Protocol
protocol SwitchModeViewDelegate: AnyObject {
    func switchModeView(with state: SwitchModeView.ButtonState)
}

final class SwitchModeView: UIButton {
    
    weak var delegate: SwitchModeViewDelegate?
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Constraint
    private func setUpConstraint() {
        setImage(LocalConstants.light, for: .normal)
        setImage(LocalConstants.dark, for: .selected)
        translatesAutoresizingMaskIntoConstraints = false
        
        addAction(UIAction(handler: { [weak self] _ in
            self?.switchModeTapped()
        }), for: .touchUpInside)
    }
    
    // MARK: SwitchMode
    private func switchModeTapped() {
        self.isSelected.toggle()
        delegate?.switchModeView(with: self.isSelected ? .light : .dark)
    }
}
