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
        self.setButtonsForPlainNavigationBarStyle(with: .red)
        self.setHideKeyboardOnTap()

        initUI()
    }

    fileprivate func initUI() {
        DispatchQueue.main.async {

            self.createAccountForm.delegate = self

            self.view.addSubview(self.createAccountForm)
            NSLayoutConstraint.activate([
                self.createAccountForm.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.createAccountForm.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.createAccountForm.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.createAccountForm.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
                ])
        }
    }

    //Components
    let createAccountForm = CreateAccountFormView()
}

extension SignUpVC: CreateAccountFormViewDelegate {
    func onContinuePressed() {
        let signUpPart2 = SignUp2VC()
        self.navigationController?.pushViewController(signUpPart2, animated: true)
    }
}
