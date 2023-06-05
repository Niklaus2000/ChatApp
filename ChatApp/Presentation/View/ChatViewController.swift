//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 18.04.23.
//

// MARK: - MessageStyle
let messages: [Message] = [
    Message(userID: 1, text: "დასწერhbaksdasdasjdnsaknxalskxnaxscjnsaknaskncanscasnasnlcnalacnanscnalncsancalnscanე", date: "11.11.1111"),
    Message(userID: 2, text: "csancihasnjlnlnslfjdnfdslflsjndfldsknfsldnvknsmv lvsmdvsngmengmlvnmwfnklwqknnvjwmflwnvnsknvwjvnsljvnv", date: "11.11.1111"),
    Message(userID: 1, text: "დასწერედსასჰბდაჯსკნდასბნკ,ნაჯ სხ,ხ აკსხ ჯკანსკხჯა ხბსკხნსა ხბხკ,ანხხ ბხაჯკნ სხახბნხასჯნხკა", date: "11.11.1111"),
    Message(userID: 2, text: "მამწეკჯხნაკსნკხან კხ აკსნხკასნკხჯდკსანკდნაკსნდკჯსანნკაჯნხხკხანსკჯხნაკხნაკსნხაკსნხკახნკხახნკასნხკასნხკაკახნსხნხა", date: "11.11.1111"),
    Message(userID: 1, text: "მამწერენდკანსკდნაკსნდკასნკადინასდჯნასინდაკსჯნდკნასკდნაკსდკნასკნდკა დკნასმნდანსკდნანდკსანკდნას", date: "11.11.1111"),
    Message(userID: 2, text: "დასწერhbaksdasdasjdnsaknxalskxnaxscjnsaknaskncanscasnasnlcnalacnanscnalncsancalnscanე", date: "11.11.1111"),
    Message(userID: 1, text: "csancihasnjlnlnslfjdnfdslflsjndfldsknfsldnvknsmv lvsmdvsngmengmlvnmwfnklwqknnvjwmflwnvnsknvwjvnsljvnv", date: "11.11.1111"),
    Message(userID: 2, text: "დასწერედსასჰბდაჯსკნდასბნკ,ნაჯ სხ,ხ აკსხ ჯკანსკხჯა ხბსკხნსა ხბხკ,ანხხ ბხაჯკნ სხახბნხასჯნხკა", date: "11.11.1111"),
    Message(userID: 1, text: "მამწეკჯხნაკსნკხან კხ აკსნხკასნკხნკაჯნხხკხანსკჯხნაკხნაკსნხაკსნხკახნკხახნკასნხკასნხკაკახნსხნხა", date: "11.11.1111"),
    Message(userID: 2, text: "მამწერენდკანსკდნაკსნდკასნკადინასდჯნასინდაკსჯნდკნასკდნაკსდკნასკნდკდასჰდნკდასნდკასნკდნსაკნდკსანდკანსკდნაკდნსკაა დკნასმნდანსკდნანდკსანკდნას", date: "11.11.1111")
]

import UIKit
final class ChatViewController: UIViewController {
    
    // MARK: Properties
    private lazy var mainStackView = UIStackView(arrangedSubviews: [topMessageView, dividerView, bottomMessageView])
    private let topMessageView = ChatView()
    private let bottomMessageView = ChatView()
    private let switchButtonView = SwitchModeView()
    private let dividerView = UIView()
    private var statusBarStyle: UIStatusBarStyle = .darkContent
    private let state: SwitchModeView.ButtonState = .light
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setUpStackView()
        setUpStackViewConstraints()
        setUpSwitchButtonViewConstraints()
        setUpDiverViewConstraints()
        
        topMessageView.tableView.dataSource = self
        bottomMessageView.tableView.dataSource = self
    }
    
    // MARK: StatusBar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    // MARK: StackView
    private func setUpStackView() {
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
    }
    
    // MARK: Add subView
    private func setUp() {
        [
            switchButtonView,
            mainStackView,
            dividerView].forEach {
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    // MARK: Constraint
    private func setUpSwitchButtonViewConstraints() {
        switchButtonView.delegate = self
        NSLayoutConstraint.activate([
            switchButtonView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.SwitchButtonView.top),
            switchButtonView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: Constants.SwitchButtonView.trailing),
            switchButtonView.widthAnchor.constraint(
                equalToConstant: Constants.SwitchButtonView.width),
            switchButtonView.heightAnchor.constraint(
                equalToConstant: Constants.SwitchButtonView.height),
        ])
    }
    
    private func setUpStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(
                equalTo: switchButtonView.bottomAnchor),
            mainStackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: Constants.StackView.bottom),
            mainStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
        ])
    }
    
    private func setUpDiverViewConstraints() {
        dividerView.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(
                equalTo: topMessageView.bottomAnchor,
                constant: Constants.DivederView.top),
            dividerView.bottomAnchor.constraint(
                equalTo: bottomMessageView.topAnchor,
                constant: Constants.DivederView.bottom),
            dividerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(
                equalToConstant: Constants.DivederView.height)
        ])
    }
}

// MARK: - SwitchModeViewDelegate
extension ChatViewController: SwitchModeViewDelegate {
    func switchModeView(_ switchModeView: SwitchModeView, didSwitchStateTo state: SwitchModeView.ButtonState) {
        switch state {
        case .light:
            setUpBackgroundColor(with: Constants.SwitchButtonView.backGroundColor)
            self.statusBarStyle = .lightContent
        case .dark:
            setUpBackgroundColor(with: .white)
            self.statusBarStyle = .darkContent
        }
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setUpBackgroundColor(with color: UIColor) {
        [
            topMessageView,
            bottomMessageView,
            view].forEach {
                $0.backgroundColor = color
            }
    }
}

 //MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        let message = messages[indexPath.row]
       
            if tableView == topMessageView.tableView {
                switch message.userID {
                case 1:
                    cell.configure(with: message, bublePosition: message.userID == 1 ? .right: .left)
                case 2:
                    cell.configure(with: message, bublePosition: message.userID == 2 ? .left: .right)
                default:
                    return UITableViewCell()
                }
            } else if tableView ==  bottomMessageView.tableView {
                switch message.userID {
                case 1:
                    cell.configure(
                        with: message, bublePosition: message.userID == 1 ? .left: .right)
                case 2:
                    cell.configure(with: message, bublePosition: message.userID == 2 ? .right: .left)
                default:
                    return UITableViewCell()
                }
            }
        
        return cell
    }
}



