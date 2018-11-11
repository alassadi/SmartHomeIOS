//
//  AccountCreationConfirmedVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-11.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

//TODO: Remove back button
class AccountCreationConfirmedVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.setConstraints()
        self.initTargets()
    }

    fileprivate func setConstraints() {
        DispatchQueue.main.async {
            self.view.addSubview(self.confirmImageView)
            self.view.addSubview(self.accountCreatedLabel)
            self.view.addSubview(self.doneButton)

            NSLayoutConstraint.activate([
                self.confirmImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
                self.confirmImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.accountCreatedLabel.topAnchor.constraint(equalTo: self.confirmImageView.bottomAnchor, constant: 30),
                self.accountCreatedLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.doneButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
                self.doneButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
                self.doneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                ])
        }
    }

    fileprivate func initTargets() {
        DispatchQueue.main.async {
            self.doneButton.button.addTarget(self, action: #selector(self.onDonebuttonPressed), for: .touchUpInside)
        }
    }

    @objc func onDonebuttonPressed() {
        self.dismiss(animated: true)
    }

    //Components
    let confirmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "confirm-solid")
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }()

    let accountCreatedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Your account has been created!"
        return label
    }()
    let doneButton = RoundedButtonView(title: "Done", backgroundColor: .red) //Localize
}
