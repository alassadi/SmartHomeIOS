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
        self.setButtonsForPlainNavigationBarStyle(with: .redish)
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

//For CreateAccountFormView delegation.
extension SignUpVC: CreateAccountFormViewDelegate {
    func onContinuePressed() {
        if self.inputsValid() {
            let signUpPart2 = SignUp2VC()
            signUpPart2.step1Form = [
                "first_name":createAccountForm.nameField.textField.text!,
                "last_name":createAccountForm.surnameField.textField.text!,
                "email":createAccountForm.emailField.textField.text!,
                "phone":createAccountForm.phoneField.textField.text!,
                "password":createAccountForm.passwordField.textField.text!
            ]
            self.navigationController?.pushViewController(signUpPart2, animated: true)
        } else {
            self.presentAlert(title: "Error", message: "Fields could not be validated.")
        }
    }
}

//Validation before continue
extension SignUpVC {
    private func inputsValid() -> Bool {
        if let fieldViews = self.createAccountForm.fieldViews {
            for fieldView in fieldViews {
                if !fieldView.hasValidInput() {
                    fieldView.bottomLine.alpha = 1.0
                    fieldView.bottomLine.backgroundColor = .redish
                    return false
                }
            }
        } else {
            print("No fields found.")
            return false
        }
        //Should not be located here. Try to keep rule logic outside of VC
        if self.createAccountForm.passwordField.textField.text
            != self.createAccountForm.confirmPasswordField.textField.text {
            self.createAccountForm.confirmPasswordField.bottomLine.backgroundColor = .redish
            self.presentAlert(title: "Error", message: "Passwords do not match!")//Localize
            return false
        }
        return true
    }
}

