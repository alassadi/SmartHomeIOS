//
//  SignUp2VC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-09.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class SignUp2VC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white


        initUI()
    }

    fileprivate func initUI() {
        DispatchQueue.main.async {

            self.createAccountForm2.delegate = self

            self.view.addSubview(self.createAccountForm2)
            NSLayoutConstraint.activate([
                self.createAccountForm2.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.createAccountForm2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.createAccountForm2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.createAccountForm2.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
                ])
        }
    }

    //Components
    let createAccountForm2 = CreateAccountFormViewStep2()
}

extension SignUp2VC: CreateAccountFormViewStep2Delegate {
    func onConfirmPressed() {
        print("Confirmed!")
    }
}
