//
//  SignUpVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-08.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        initUI()
    }

    fileprivate func initUI() {
        DispatchQueue.main.async {
            self.view.addSubview(self.textFieldView)

            NSLayoutConstraint.activate([
                self.textFieldView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
                self.textFieldView.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -50),
                self.textFieldView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50)
                ])
        }
    }

    let textFieldView = IconAndLinedTextFieldView.init(placeholder: "name", icon: nil, tintColor: .yellow)
}
