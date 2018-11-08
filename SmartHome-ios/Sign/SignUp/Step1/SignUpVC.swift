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
        initTargets()
    }

    fileprivate func initUI() {
        DispatchQueue.main.async {
//            self.view.addSubview(self.labelCreateAnAccount)
//
//            [self.nameField,
//             self.surnameField,
//             self.emailField,
//             self.phoneField,
//             self.passwordField,
//             self.confirmPasswordField]
//                .forEach({self.stackView.addArrangedSubview($0)})
//
//            self.view.addSubview(self.stackView)
//            self.view.addSubview(self.continueButton)
//
//            NSLayoutConstraint.activate([
//                self.labelCreateAnAccount.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
//                self.labelCreateAnAccount.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//                self.labelCreateAnAccount.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//                self.stackView.topAnchor.constraint(equalTo: self.labelCreateAnAccount.bottomAnchor, constant: 30),
//                self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
//                self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
//                self.continueButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
//                self.continueButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
//                self.continueButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
//                ])
            self.view.addSubview(self.createAccountForm)

            NSLayoutConstraint.activate([
                self.createAccountForm.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.createAccountForm.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.createAccountForm.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.createAccountForm.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
                ])
        }
    }

    private func initTargets() {
        DispatchQueue.main.async {
//            self.continueButton.button.addTarget(self, action: #selector(self.onContinuePressed), for: .touchUpInside)
        }
    }

    @objc func onContinuePressed() {
        let step2VC = SignUp2VC()
        self.navigationController?.pushViewController(step2VC, animated: true)
    }

    //Components
    let createAccountForm = CreateAccountFormView()
//    let labelCreateAnAccount: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Create an account" //Localize
//        label.font = UIFont.boldSystemFont(ofSize: 16.0)
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//
//    let stackView: UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.distribution = .fill
//        stack.spacing = 10
//        return stack
//    }()
//
//    let nameField = FormTextFieldView.init(placeholder: "Name", icon: #imageLiteral(resourceName: "person-solid"), iconSize: 20, tintColor: .red) //Localize
//    let surnameField = FormTextFieldView.init(placeholder: "Surname", icon: nil, iconSize: 20, tintColor: .red) //Localize
//    let emailField = FormTextFieldView.init(placeholder: "Email", icon: #imageLiteral(resourceName: "email-solid"), iconSize: 20, tintColor: .red) //Localize
//    let phoneField = FormTextFieldView.init(placeholder: "Phone", icon: #imageLiteral(resourceName: "phone-solid"), iconSize: 20, tintColor: .red) //Localize
//    let passwordField = FormTextFieldView.init(placeholder: "Password", icon: #imageLiteral(resourceName: "lock-solid"), iconSize: 20, tintColor: .red) //Localize
//    let confirmPasswordField = FormTextFieldView.init(placeholder: "Confirm password", icon: nil, iconSize: 20, tintColor: .red) //Localize
//
//    let continueButton = RoundedButtonView(title: "Continue", backgroundColor: .red) //Localize
}
