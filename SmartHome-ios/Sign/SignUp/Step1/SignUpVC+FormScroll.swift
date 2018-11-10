//
//  SignUpVC+FormScroll.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-10.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

protocol CreateAccountFormViewDelegate {
    func onContinuePressed()
}

class CreateAccountFormView: UIView {

    var delegate: CreateAccountFormViewDelegate?

    init() {
        //Set field variables here.

        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        self.setConstraints()
        self.initTargets()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setConstraints() {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true

        self.addSubview(scrollView)
        scrollView.addSubview(self.labelCreateAnAccount)
        scrollView.addSubview(self.stackView)

        [self.nameField,
         self.surnameField,
         self.emailField,
         self.phoneField,
         self.passwordField,
         self.confirmPasswordField]
            .forEach({self.stackView.addArrangedSubview($0)})

        scrollView.addSubview(self.continueButton)


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.labelCreateAnAccount.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            self.labelCreateAnAccount.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.labelCreateAnAccount.bottomAnchor, constant: 30),
            self.stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            self.stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100),
            self.continueButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            self.continueButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7),
            self.continueButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            self.continueButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25)
            ])
    }

    private func initTargets() {
        DispatchQueue.main.async {
            self.continueButton.button.addTarget(self, action: #selector(self.onContinuePressed), for: .touchUpInside)
        }
    }

    @objc func onContinuePressed() {
        delegate?.onContinuePressed()
    }

    //Components
    let labelCreateAnAccount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create an account" //Localize
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()

    let nameField = FormTextFieldView.init(placeholder: "Name", icon: #imageLiteral(resourceName: "person-solid"), iconSize: 20, tintColor: .red) //Localize
    let surnameField = FormTextFieldView.init(placeholder: "Surname", icon: nil, iconSize: 20, tintColor: .red) //Localize
    let emailField = FormTextFieldView.init(placeholder: "Email", icon: #imageLiteral(resourceName: "email-solid"), iconSize: 20, tintColor: .red) //Localize
    let phoneField = FormTextFieldView.init(placeholder: "Phone", icon: #imageLiteral(resourceName: "phone-solid"), iconSize: 20, tintColor: .red) //Localize
    let passwordField = FormTextFieldView.init(placeholder: "Password", icon: #imageLiteral(resourceName: "lock-solid"), iconSize: 20, tintColor: .red) //Localize
    let confirmPasswordField = FormTextFieldView.init(placeholder: "Confirm password", icon: nil, iconSize: 20, tintColor: .red) //Localize

    let continueButton = RoundedButtonView(title: "Continue", backgroundColor: .red) //Localize
}
