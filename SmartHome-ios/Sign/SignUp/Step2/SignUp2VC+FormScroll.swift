//
//  SignUp2VC+FormScroll.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-10.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

protocol CreateAccountFormViewStep2Delegate {
    func onConfirmPressed()
}

class CreateAccountFormViewStep2: UIView {

    var delegate: CreateAccountFormViewStep2Delegate?

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

        [self.address,
         self.postal_code,
         self.city,
         self.country,
         self.birthday,
         self.gender]
            .forEach({self.stackView.addArrangedSubview($0)})

        scrollView.addSubview(self.confirmButton)

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
            self.confirmButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            self.confirmButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7),
            self.confirmButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            self.confirmButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25)
            ])

        self.country.setAsADropDownMenu()
        self.birthday.setAsADropDownMenu()
        self.gender.setAsADropDownMenu()
    }

    private func initTargets() {
        DispatchQueue.main.async {
            self.confirmButton.button.addTarget(self, action: #selector(self.onContinuePressed), for: .touchUpInside)
        }
    }

    @objc func onContinuePressed() {
        delegate?.onConfirmPressed()
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

    let address = FormTextFieldView.init(placeholder: "Address", icon: #imageLiteral(resourceName: "location-solid"), iconSize: 20, tintColor: .red) //Localize
    let postal_code = FormTextFieldView.init(type: .numerical, placeholder: "Postal Code", icon: nil, iconSize: 20, tintColor: .red) //Localize
    let city = FormTextFieldView.init(placeholder: "City", icon: nil, iconSize: 20, tintColor: .red) //Localize
    let country = FormTextFieldView.init(type: .dropDown, placeholder: "Country", icon: #imageLiteral(resourceName: "globe-solid"), iconSize: 20, tintColor: .red) //Localize
    let birthday = FormTextFieldView.init(type: .dropDownDate, placeholder: "Birthday", icon: #imageLiteral(resourceName: "birthday-solid"), iconSize: 20, tintColor: .red) //Localize
    let gender = FormTextFieldView.init(type: .dropDown, placeholder: "Gender", icon: nil, iconSize: 20, tintColor: .red) //Localize

    let confirmButton = RoundedButtonView(title: "Confirm", backgroundColor: .red) //Localize
}
