//
//  SideMenuVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-12.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseMessaging

class SideMenuVC: UIViewController {

    let optionList = ["Dashboard", "Rooms", "Log out"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.setConstraints()
        self.initUI()
    }

    private func setConstraints() {
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.email)
        self.view.addSubview(self.loggedInAs)
        self.view.addSubview(self.iconLabel)
        self.view.addSubview(self.brand)

        self.backgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(UIScreen.main.bounds.height*0.08)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        self.iconLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.backgroundView)
            make.centerX.equalToSuperview()
        }

        self.brand.snp.makeConstraints { (make) in
            make.top.equalTo(self.backgroundView.snp.bottom)
            make.centerX.equalToSuperview()
        }

        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.brand.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.loggedInAs.snp.top)
        }

        self.email.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }

        self.loggedInAs.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.email.snp.top).offset(-2)
        }
    }

    private func initUI() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(SideMenuCell.self, forCellReuseIdentifier: "sideMenuCell")
        self.tableView.tableFooterView = UIView()

        self.email.text = Auth.auth().currentUser?.email
    }

    private func onLogOutPressed() {
        do {
            try Auth.auth().signOut()
            Messaging.messaging().unsubscribe(fromTopic: "deviceUpdate") { error in
                print("unscribed from topic deviceUpdate")
            }
            UserDefaults.standard.reset()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginVC()
        } catch {
            print("Couldn't log out")
        }
    }

    let iconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: FontNames.FAPro_solid, size: 60)
        label.textColor = .yellowish
        label.text = "bolt"
        return label
    }()

    let brand: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .redish
        label.text = "SmartHome"
        return label
    }()

    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .blackish
        return view
    }()

    let loggedInAs: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.text = "Logged in as"
        label.textColor = .blackish
        return label
    }()

    let email: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment = .center
        label.textColor = .redish
        return label
    }()

    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
}

extension SideMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/2/4
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch optionList[indexPath.row] {
        case "Dashboard":
            MainTabBarVC.selectedIndex.value = 0
            MainVC.sideMenuOpen.value = false
        case "Rooms":
            MainTabBarVC.selectedIndex.value = 1
            MainVC.sideMenuOpen.value = false
        case "Log out":
            self.onLogOutPressed()
        default:
            print("Something went horribly wrong.")
        }
    }
}

extension SideMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SideMenuCell = {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell") as! SideMenuCell
            cell.title = self.optionList[indexPath.row]
            return cell
        }()
        return cell
    }
}
