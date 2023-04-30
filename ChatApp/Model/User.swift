//
//  User.swift
//  ChatApp
//
//  Created by MacBoobPro on 19.04.23.
//

import Foundation


import UIKit

class User: UIViewController {



    

    //    let tableView: UITableView = {
    //        let  table = UITableView()
    //        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    //        return table.contentInset = UIEdgeInsets(top: 20, left:16, bottom: 0, right: 16)
    //    }()

    var tableView: UITableView!

    //  @IBOutlet weak var segmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView = UITableView(frame: .zero, style: .plain)
//
//
//        tableView.dataSource = self
//        tableView.delegate = self
//
//
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//
//        view.addSubview(tableView)
//
//        let topConstraint = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
//        let leadingConstraint = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//        let trailingConstraint = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])


//        view.addSubview(segmentControl)
//        NSLayoutConstraint.activate([
//            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -12),
//            segmentControl.topAnchor.constraint(equalTo: view.topAnchor,constant: 8),
//            segmentControl.widthAnchor.constraint(equalToConstant: 54),
//            segmentControl.heightAnchor.constraint(equalToConstant: 27)
//        ])

        let imageSegmentControl = UISegmentedControl()
        imageSegmentControl.frame = CGRect(x: 50, y: 100, width: 200, height: 30)
        imageSegmentControl.insertSegment(with: UIImage(named: "sun"), at: 0, animated: true)
        imageSegmentControl.insertSegment(with: UIImage(named: "sun"), at: 1, animated: true)
        //        NSLayoutConstraint.activate([
        //            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -12),
        //            segmentControl.topAnchor.constraint(equalTo: view.topAnchor,constant: 8),
        //            segmentControl.widthAnchor.constraint(equalToConstant: 54),
        //            segmentControl.heightAnchor.constraint(equalToConstant: 27)
        //        ])
        view.addSubview(imageSegmentControl)


        if let backgroundColorIndex = UserDefaults.standard.value(forKey: "backgroundColorSegmentIndex") as? Int {
            imageSegmentControl.selectedSegmentIndex = backgroundColorIndex
            segmentControllClick(imageSegmentControl)
        }

        //    override func viewDidAppear(_ animated: Bool) {
        //        super.viewDidAppear(animated)
        //        if let backgroundColorIndex = UserDefaults.standard.value(forKey: "backgroundColorSegmentIndex") as? Int {
        //            segmentControl.selectedSegmentIndex = backgroundColorIndex
        //            segmentControllClick(segmentControl)
        //        }
        //    }
        //        @IBAction func segmentControllClick(_ sender: UISegmentedControl) {
        //        switch sender.selectedSegmentIndex {
        //            case 0:
        //                view.backgroundColor = .white
        //            case 1 :
        //                view.backgroundColor = .green
        //            default:
        //            view.backgroundColor =  .white
        //
        //            }
        //            UserDefaults.standard.set(segmentControl.selectedSegmentIndex, forKey: "backgroundColorSegmentIndex")
        //        }
        func segmentControllClick(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0:
                view.backgroundColor = .white
            case 1 :
                view.backgroundColor = .green
            default:
                view.backgroundColor =  .white

            }
            UserDefaults.standard.set(imageSegmentControl.selectedSegmentIndex, forKey: "backgroundColorSegmentIndex")

        }


    }
}

//    extension ViewController: UITableViewDataSource, UITableViewDelegate {
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//            }
//
//            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//            }
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        }
//
//
//    }

