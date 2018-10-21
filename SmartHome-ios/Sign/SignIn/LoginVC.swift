//
//  LoginVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-19.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        initUI()
        initTargets()
    }
    
    private func initUI() {
        DispatchQueue.main.async {
            self.view.addSubview(self.stackHeader)
            self.stackHeader.addArrangedSubview(self.labelReplaceWithLogo)
            self.stackHeader.addArrangedSubview(self.labelLoginToContinue)
            self.view.addSubview(self.stackEmailPassword)
            self.view.addSubview(self.buttonCreateAccount)
            self.view.addSubview(self.labelDontHaveAccount)
            
            NSLayoutConstraint.activate([
                self.stackHeader.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
                self.stackHeader.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                self.stackHeader.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                self.stackEmailPassword.topAnchor.constraint(equalTo: self.stackHeader.bottomAnchor, constant: 60),
                self.stackEmailPassword.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
                self.stackEmailPassword.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
                self.buttonCreateAccount.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
                self.buttonCreateAccount.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.labelDontHaveAccount.bottomAnchor.constraint(equalTo: self.buttonCreateAccount.topAnchor),
                self.labelDontHaveAccount.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                ])
        }
    }
    
    private func initTargets() {
        DispatchQueue.main.async {
            self.buttonCreateAccount.addTarget(self, action: #selector(self.onCreateAccountClicked), for: .touchUpInside)
        }
    }
    
    @objc private func onCreateAccountClicked() {
        print("Create account pressed.")
    }
    
    let stackHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    let labelReplaceWithLogo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SmartHome App"
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    let labelLoginToContinue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please log in to continue"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
        return label
    }()
    
    let stackEmailPassword = EmailPasswordStack()
    
    let labelDontHaveAccount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have an account?"
        return label
    }()
    
    let buttonCreateAccount: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create new account", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.isEnabled = true
        return button
    }()
}
