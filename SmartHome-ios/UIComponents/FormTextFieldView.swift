//
//  IconAndLinedTextField.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-08.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

/* Delegate methods for any subview in this class can be implemented
 as an extension at the bottom of this file and can be recalled inside
 this protocol when a higher level delegation needed. */
protocol IconAndLinedTextFieldViewDelegate {
    func textFieldDidBeginEditing()
    func textFieldDidEndEditing()
}

class FormTextFieldView: UIView {

    var delegate: IconAndLinedTextFieldViewDelegate?
    let defaultIconSize: CGFloat = 20
    var iconSize: CGFloat?

    init(height: CGFloat = 200, placeholder: String?, icon: UIImage?, iconSize: CGFloat?, tintColor: UIColor?) {
        //Set field variables here.
        /* iconSize is used to determine the size of the icon subview. If it is not
         given it will be accepted as whatever the defaultIconSize field variable has its constant
         value. iconSize will effect the layout of your view even if you pass a nil for your icon image. */
        self.iconSize = iconSize

        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true

        self.textField.delegate = self

        if let tintColor = tintColor {
            self.tintColor = tintColor
        }

        if let placeholder = placeholder {
            self.textField.placeholder = placeholder
        }

        if let icon = icon {
            self.icon.image = icon
        }

        self.setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setConstraints() {
        self.addSubview(self.icon)
        self.addSubview(self.textField)
        self.addSubview(self.bottomLine)

        NSLayoutConstraint.activate([
            self.icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.icon.heightAnchor.constraint(equalToConstant: self.iconSize ?? self.defaultIconSize),
            self.icon.widthAnchor.constraint(equalToConstant: self.iconSize ?? self.defaultIconSize),
            self.textField.leadingAnchor.constraint(equalTo: self.icon.trailingAnchor, constant: 12),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(self.iconSize ?? self.defaultIconSize)),
            self.textField.topAnchor.constraint(equalTo: self.topAnchor),
            self.textField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0),
            self.bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.bottomLine.leadingAnchor.constraint(equalTo: self.textField.leadingAnchor),
            self.bottomLine.trailingAnchor.constraint(equalTo: self.textField.trailingAnchor)
            ])
    }

    let stackView = UIStackView()

    let icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
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

extension FormTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.bottomLine.backgroundColor = self.tintColor
        self.delegate?.textFieldDidBeginEditing()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.bottomLine.backgroundColor = .black
        self.delegate?.textFieldDidBeginEditing()
    }
}
