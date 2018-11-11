//
//  SignUp2VC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-09.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class SignUp2VC: UIViewController {

    var step1Form: [String:String]?

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

//TODO: Refactor this big time with step1 included
//For CreateAccountFormViewStep2 delegation.
extension SignUp2VC: CreateAccountFormViewStep2Delegate {
    func onConfirmPressed() {
        if self.inputsValid() {
            let body = [
                "address": self.createAccountForm2.addressField.textField.text!,
                "postal_code": self.createAccountForm2.postalCodeField.textField.text!,
                "city": self.createAccountForm2.cityField.textField.text!,
                "country": self.createAccountForm2.countryField.textField.text!,
                "date_of_birth": self.createAccountForm2.birthdayField.textField.text!,
                "gender": self.createAccountForm2.genderField.textField.text!
            ]
            if let step1 = self.step1Form {
                APICreateAccount.init(params: body.merged(with: step1)).execute(onSuccess: { (response) in
                    print("success: \(response)")
                    self.navigationController?.pushViewController(AccountCreationConfirmedVC(), animated: true)
                }) { (error) in
                    print(error)
                }
            }
        } else {
            self.presentAlert(title: "Error", message: "Fields could not be validated.")
        }
    }
}

//Validation before continue
extension SignUp2VC {
    private func inputsValid() -> Bool {
        if let fieldViews = self.createAccountForm2.fieldViews {
            for fieldView in fieldViews {
                if !fieldView.hasValidInput() {
                    fieldView.bottomLine.alpha = 1.0
                    fieldView.bottomLine.backgroundColor = .red
                    return false
                }
            }
        } else {
            print("No fields found.")
            return false
        }
        return true
    }
}

