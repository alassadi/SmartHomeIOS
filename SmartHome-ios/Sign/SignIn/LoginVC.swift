//
//  LoginVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-19.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit
import FirebaseAuth
import KeychainAccess

class LoginVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setHideKeyboardOnTap()
        
        initUI()
        initTargets()
    }
    
    private func initUI() {
        DispatchQueue.main.async {
            self.view.addSubview(self.stackHeader)
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
            self.buttonCreateAccount.addTarget(self, action: #selector(self.onCreateAccountPressed), for: .touchUpInside)
            self.stackEmailPassword.buttonLogin.button.addTarget(self, action: #selector(self.onLoginPressed), for: .touchUpInside)
        }
    }

    @objc private func onLoginPressed(sender: UIButton) {
        sender.setAsLoading(true, with: .white)
        guard let email = self.stackEmailPassword.textFieldEmail.text  else {
            self.presentAlert(title: "Error", message: "Invalid email.") // Localize
            return
        }

        guard let password = self.stackEmailPassword.textFieldPassword.text else {
            self.presentAlert(title: "Error", message: "Invalid password.") // Localize
            return
        }

        if !email.isEmpty, !password.isEmpty {
            Auth.auth().signIn(withEmail: email, password: password) {
                (auth, error) in
                if let error = error {
                    print(error)
                }
                if let auth = auth {
                    let mainVC = MainVC()
                    UserDefaults.standard.setAppUserId(id: auth.user.uid)

                    do {
                        if let fcmToken = try Keychain(service: "com.charlie.SmartHome-ios-test").get("fcm_token") {
                            APIRegisterUnit(params: ["fcm_token":fcmToken])
                                .execute(onSuccess: { (response) in
                                }, onError: { (error) in
                                    print(error)
                                })
                        } else {
                            print("fcm_token was nil in keychain.")
                        }
                    } catch {
                        print("Could not read fcm_token from keychain.")
                    }

                    self.present(mainVC, animated: true)
                }
            }
        } else {
            self.presentAlert(title: "Error", message: "Fields are empty!")
            sender.setAsLoading(false)
        }
    }
    
    @objc private func onCreateAccountPressed() {
        print("Create account pressed.")
        DispatchQueue.main.async {
            let navController = UINavigationController.plainStyledNavigationController()
            let signUpVC = SignUpVC()
            navController.pushViewController(signUpVC, animated: false)
            self.present(navController, animated: true)
        }
    }

    //Components
    let stackHeader = HeaderStack()
    
    let stackEmailPassword = EmailPasswordStack()
    
    let labelDontHaveAccount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have an account?" //Localize
        return label
    }()
    
    let buttonCreateAccount: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create new account", for: .normal) //Localize
        button.setTitleColor(.redish, for: .normal)
        button.isEnabled = true
        return button
    }()
}
