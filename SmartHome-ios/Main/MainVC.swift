//
//  MainVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-11.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.setConstraints()
        self.initBinds()
        self.initTargets()
    }

    fileprivate func setConstraints() {
        DispatchQueue.main.async {
            self.view.addSubview(self.button1)
            self.view.addSubview(self.button2)
            self.view.addSubview(self.button3)
            self.view.addSubview(self.label)
            self.view.addSubview(self.status)

            NSLayoutConstraint.activate([
                self.label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 70),
                self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.status.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 8),
                self.status.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.button1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
                self.button1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
                self.button1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.button2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
                self.button2.topAnchor.constraint(equalTo: self.button1.bottomAnchor, constant: 20),
                self.button2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.button3.topAnchor.constraint(equalTo: self.button2.bottomAnchor, constant: 20),
                self.button3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.button3.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7)
                ])
        }
    }

    fileprivate func initTargets() {
        DispatchQueue.main.async {
            self.button1.button.addTarget(self, action: #selector(self.onButton1Pressed), for: .touchUpInside)
            self.button2.button.addTarget(self, action: #selector(self.onButton2Pressed), for: .touchUpInside)
            self.button3.button.addTarget(self, action: #selector(self.onButton3Pressed), for: .touchUpInside)
            self.status.addTarget(self, action: #selector(self.onSwitchToggled), for: .valueChanged)
        }
    }

    fileprivate func initBinds() {
        HomeVC.boxedStatus.bind { (bool) in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.status.isOn = bool
                })
            }
        }
    }

    @objc func onButton1Pressed() {
        print("LogOut")

        do {
            try Auth.auth().signOut()
        } catch {
            print("Could not log out")
        }
        self.present(LoginVC(), animated: true)
    }

    @objc func onButton2Pressed() {
        print("SendFCM")
    }

    @objc func onButton3Pressed() {
        print("Refreshed")
        APIDeviceStatus(params: ["id":"my9iXu6WvEgx5oNLLegs"]).execute(onSuccess: { (device_status) in
            if let status = device_status.enabled {
                HomeVC.boxedStatus.value = status
                print("status: \(status)")
            }
        }) { (error) in
            print(error)
        }
    }

    @objc func onSwitchToggled(sender: UISwitch) {
        APIUpdateDevice(params: ["id":"my9iXu6WvEgx5oNLLegs",
                                 "enabled":sender.isOn]).execute(onSuccess: { (bool) in
                                    HomeVC.boxedStatus.value = bool
                                    print("newStatus: \(bool)")
                                 }) { (error) in
                                    print(error)
        }
    }

    //Components
    let button1 = RoundedButtonView(title: "Log Out", backgroundColor: .black)
    let button2 = RoundedButtonView(title: "Send FCM registration id", backgroundColor: .blue)
    let button3 = RoundedButtonView(title: "Refresh", backgroundColor: .orange)

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Light status: "
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    let status: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()
}
