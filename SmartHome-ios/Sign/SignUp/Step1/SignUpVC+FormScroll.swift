//
//  SignUpVC+FormScroll.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-10.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class CreateAccountFormView: UIView {

    init() {
        //Set field variables here.

        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        self.setConstraints()
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

        //scrollView.addSubview(self.continueButton)
        
        scrollView.contentSize.height =
            stackView.bounds.height
            + continueButton.bounds.height
            + continueButton.bounds.height + 30 + 30 + 10000

        scrollView.contentSize.width = UIScreen.main.bounds.width

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.labelCreateAnAccount.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            self.labelCreateAnAccount.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            self.labelCreateAnAccount.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.labelCreateAnAccount.bottomAnchor, constant: 30),
            self.stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            self.stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
//            self.continueButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 50),
//            self.continueButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -50),
//            self.continueButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25)
            ])
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
