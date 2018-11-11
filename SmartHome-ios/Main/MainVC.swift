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
        self.initTargets()
    }

    fileprivate func setConstraints() {
        DispatchQueue.main.async {
            self.view.addSubview(self.button1)
            self.view.addSubview(self.button2)

            NSLayoutConstraint.activate([
                self.button1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
                self.button1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
                self.button1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.button2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
                self.button2.topAnchor.constraint(equalTo: self.button1.bottomAnchor, constant: 20),
                self.button2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                ])
        }
    }

    fileprivate func initTargets() {
        DispatchQueue.main.async {
            self.button1.button.addTarget(self, action: #selector(self.onButton1Pressed), for: .touchUpInside)
            self.button2.button.addTarget(self, action: #selector(self.onButton2Pressed), for: .touchUpInside)
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

    let button1 = RoundedButtonView(title: "Log Out", backgroundColor: .black)
    let button2 = RoundedButtonView(title: "Send FCM registration id", backgroundColor: .blue)

}
