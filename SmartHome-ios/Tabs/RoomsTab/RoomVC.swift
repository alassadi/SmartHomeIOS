//
//  RoomVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2019-01-07.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class RoomVC: UIViewController {

    var ref: DatabaseReference!
    var roomId: String!
    var deviceList = [_device]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ref = Database.database().reference()

        getDevices()
        initUI()
    }

    private func initUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(DeviceCell.self, forCellReuseIdentifier: "deviceCell")
        self.tableView.tableFooterView = UIView()

        self.view.addSubview(self.tableView)

        self.tableView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }

    private func getDevices() {
        APIGetDevicesForRoom(roomId: self.roomId).execute(onSuccess: { (response) in
            self.deviceList = response
            self.tableView.reloadData()
        }) { (error) in
            print("Error: ", error)
        }
    }

    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
}

extension RoomVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.deviceList[indexPath.row].name!)
    }
}

extension RoomVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DeviceCell = {
            let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell") as! DeviceCell
            cell.device = deviceList[indexPath.row]
            cell.delegate = self
            return cell
        }()
        return cell
    }
}

extension RoomVC: DeviceCellDelegate {
    func switchToggledFor(id: String, to value: String) {
        for (index, device) in self.deviceList.enumerated() {
            if device.id == id {
                self.deviceList[index].value = value
            }
        }
        self.tableView.reloadData()
    }
}
