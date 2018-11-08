//
//  EmailPasswordStack.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-23.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class EmailPasswordStack: UIStackView {
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.spacing = 20
        self.axis = .vertical
        [textFieldUsername,
         viewDividerUsername,
         textFieldPassword,
         viewDividerPassword,
         buttonLogin]
            .forEach({addArrangedSubview($0)})
        self.setCustomSpacing(60, after: viewDividerPassword)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Components
    let textFieldUsername: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Username or Email" //Localize
        field.keyboardType = .emailAddress
        return field
    }()
    
    let viewDividerUsername: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    
    let textFieldPassword: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Password" //Localize
        return field
    }()
    
    let viewDividerPassword: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    
    let buttonLogin = RoundedButtonView(title: "Log in", backgroundColor: .red) //Localize
}
