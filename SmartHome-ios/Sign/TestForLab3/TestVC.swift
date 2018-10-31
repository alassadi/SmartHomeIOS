//
//  TestVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        initTargets()
        initUI()
    }

    private func initUI() {
        DispatchQueue.main.async {
            self.activateHideKeyboardOnTap()
            self.view.addSubview(self.idField)
            self.view.addSubview(self.fieldStack)
            self.view.addSubview(self.getId)
            self.view.addSubview(self.buttonGet)
            self.view.addSubview(self.result)
            [self.textFieldName,
             self.textFieldSurname,
             self.textFieldDescription,
             self.button].forEach({self.fieldStack.addArrangedSubview($0)})
            self.fieldStack.setCustomSpacing(20, after: self.textFieldDescription)

            NSLayoutConstraint.activate([
                self.idField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
                self.idField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                self.idField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
                self.fieldStack.topAnchor.constraint(equalTo: self.idField.topAnchor, constant: 100),
                self.fieldStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
                self.fieldStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
                self.getId.topAnchor.constraint(equalTo: self.fieldStack.bottomAnchor, constant: 40),
                self.getId.leadingAnchor.constraint(equalTo: self.fieldStack.leadingAnchor),
                self.getId.trailingAnchor.constraint(equalTo: self.fieldStack.trailingAnchor),
                self.buttonGet.leadingAnchor.constraint(equalTo: self.getId.leadingAnchor),
                self.buttonGet.trailingAnchor.constraint(equalTo: self.getId.trailingAnchor),
                self.buttonGet.topAnchor.constraint(equalTo: self.getId.bottomAnchor, constant: 20),
                self.result.topAnchor.constraint(equalTo: self.buttonGet.bottomAnchor, constant: 40),
                self.result.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                ])
        }
    }

    private func initTargets() {
        DispatchQueue.main.async {
            self.button.button.addTarget(self, action: #selector(self.handleButtonCreate), for: .touchUpInside)
            self.buttonGet.button.addTarget(self, action: #selector(self.handleGetButton), for: .touchUpInside)
        }
    }

    @objc func handleButtonCreate() {
        let params = [
            "name": self.textFieldName.text!,
            "surname": self.textFieldSurname.text!,
            "description": self.textFieldDescription.text!
            ]
        APICreateFriend(params: params).execute(onSuccess: { (friend) in
            if let id = friend._id {
                DispatchQueue.main.async {
                    self.idField.text = id
                }
                print(friend)
            } else {
                print("Could not get id.")
            }
        }) { (error) in
            print("Something went wrong -> \(error)")

        }
    }

    @objc func handleGetButton() {
        if let id = self.getId.text, !id.isEmpty {
            APIGetFriend(friendId: id).execute(onSuccess: { (friend) in
                if let name = friend.name, let surname = friend.surname {
                    DispatchQueue.main.async {
                        self.result.text = "\(name) \(surname)"
                    }
                } else {
                    print("Could not get name or surname.")
                }
            }) { (error) in
                print("Something went wrong -> \(error)")
            }
        }
    }

    //Components
    let idField: UITextField = {
        let textView = UITextField()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "-"
        return textView
    }()

    let fieldStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        stack.backgroundColor = UIColor(displayP3Red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        return stack
    }()

    let textFieldName: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "name"
        return field
    }()

    let textFieldSurname: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "surname"
        return field
    }()

    let textFieldDescription: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "description"
        return field
    }()

    let button = RoundedButtonView(title: "Save", backgroundColor: .blue) //Localize

    let getId: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "id"
        return field
    }()

    let buttonGet = RoundedButtonView(title: "Get", backgroundColor: .blue) //Localize

    let result: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        return label
    }()
}
