//
//  RoomsVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2019-01-06.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class RoomsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }

    private func initUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
}

extension RoomsVC: UITableViewDelegate {

}

extension RoomsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        
        return cell
    }
}
