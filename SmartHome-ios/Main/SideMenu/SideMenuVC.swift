//
//  SideMenuVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-12.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit
import FirebaseAuth

class SideMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.setConstraints()
        self.initUI()
        self.initTargets()
    }

    private func setConstraints() {
        self.view.addSubview(self.email)
        self.view.addSubview(self.logOutButton)
        self.view.addSubview(self.loggedInAs)

        loggedInAs.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(26)
        }

        email.snp.makeConstraints { (make) in
            make.top.equalTo(loggedInAs.snp.bottom).offset(8)
            make.leading.equalTo(loggedInAs.snp.leading)
        }

        logOutButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-26)
            make.leading.equalToSuperview().offset(26)
        }
    }

    private func initUI() {
        self.email.text = Auth.auth().currentUser?.email
    }

    private func initTargets() {
        logOutButton.addTarget(self, action: #selector(onLogOutPressed), for: .touchUpInside)
    }

    @objc func onLogOutPressed() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.reset()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginVC()
        } catch {
            print("Couldn't log out")
        }
    }

    let loggedInAs: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Logged in as: "
        return label
    }()

    let email: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log out", for: .normal) //Localize
        button.setTitleColor(.red, for: .normal)
        button.isEnabled = true
        return button
    }()
}
