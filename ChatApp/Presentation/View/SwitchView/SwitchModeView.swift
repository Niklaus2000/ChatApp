import UIKit

// MARK: Switch Protocol
protocol SwitchModeViewDelegate: AnyObject {
    func switchModeView(_ switchModeView: SwitchModeView, didSwitchStateTo state: SwitchModeView.ButtonState)
}

final class SwitchModeView: UIButton {
    
    weak var delegate: SwitchModeViewDelegate?
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Constraint
    private func setUp() {
        setImage(LocalConstants.light, for: .normal)
        setImage(LocalConstants.dark, for: .selected)
        translatesAutoresizingMaskIntoConstraints = false
        
        addAction(UIAction(handler: {[weak self] _ in
            self?.switchModeTapped()
        }), for: .touchUpInside)
    }
    
    // MARK: SwitchMode
    private func switchModeTapped() {
        isSelected.toggle()
        delegate?.switchModeView(self, didSwitchStateTo: isSelected ? .light : .dark)
    }}
