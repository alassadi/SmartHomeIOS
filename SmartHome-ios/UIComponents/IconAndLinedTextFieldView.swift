//
//  IconAndLinedTextField.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-08.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class IconAndLinedTextFieldView: UIView {

    init(placeholder: String?, icon: UIImage?, tintColor: UIColor?) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true

        if let placeholder = placeholder {
            self.textField.placeholder = placeholder
        }

        if let icon = icon {
            self.icon.image = icon
        }

        //TODO: Tint color for bottom line.

        self.setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setConstraints() {
        [self.icon,
         self.textField]
            .forEach({self.stackView.addArrangedSubview($0)})
        stackView.axis = .horizontal
        stackView.alignment = .fill

        self.addSubview(stackView)
        //self.addSubview(bottomLine)
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }

    let stackView = UIStackView()

    let icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        icon.backgroundColor = .yellow
        return icon
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let bottomLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
}
