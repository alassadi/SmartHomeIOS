//
//  RoomsVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2019-01-06.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseDatabase

class RoomListVC: UIViewController {

    var ref: DatabaseReference!
    var roomList = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .blackish

        ref = Database.database().reference()

        initUI()
    }

    private func initUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()

        self.view.addSubview(self.tableView)

        self.tableView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalToSuperview()
        }

        ref.child("Rooms").observe(.value) { (snapshot) in
            if let values = snapshot.value as? [String:Any] {
                self.roomList.removeAll()
                self.roomList = values
                self.tableView.reloadData()
            }
        }
    }

    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
}

extension RoomListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roomId = Array(self.roomList.keys)[indexPath.row]
        let roomVC = RoomVC()

        switch roomId {
        case "K7F2O2YJLAWJxy4t9DI9": roomVC.title = "Inside"
        case "x80HetypgBJIrdJc36gh": roomVC.title = "Upstairs" //WOW..
        case "xXKPpHKTbMWCXDluthqz": roomVC.title = "Outside"
        default: roomVC.title = "Room"
        }

        roomVC.roomId = roomId
        self.navigationController?.pushViewController(roomVC, animated: true)
    }
}

extension RoomListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        if let roomDictionary = self.roomList[Array(self.roomList.keys)[indexPath.row]] as? [String:Any] {
            if let roomName = roomDictionary["room_name"] as? String {
                cell.textLabel?.text = roomName.capitalized
                cell.textLabel?.textColor = .redish
            }
        }
        return cell
    }
}
