//
//  IconAndLinedTextField.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-08.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

//TODO: Turn these into more app spesific types, that...
//...will make validation process more straight forward and...
//...maintainable.
enum FormTextFieldType {
    case normal
    case email
    case phone
    case password
    case numerical
    case dropDown
    case dropDownDate
}

/* Delegate methods for any subview in this class can be implemented
 as an extension at the bottom of this file and can be recalled inside
 this protocol when a higher level delegation needed. */
protocol IconAndLinedTextFieldViewDelegate {
    func textFieldDidBeginEditing()
    func textFieldDidEndEditing()
}

class FormTextFieldView: UIView {

    var delegate: IconAndLinedTextFieldViewDelegate?
    var isADropDownMenu = false
    let defaultIconSize: CGFloat = 20
    var iconSize: CGFloat?
    var type: FormTextFieldType!

    init(type: FormTextFieldType = .normal, height: CGFloat = 40, placeholder: String?, icon: UIImage?, iconSize: CGFloat? = 20, tintColor: UIColor?) {
        //Set field variables here.
        /* iconSize is used to determine the size of the icon subview. If it is not
         given it will be accepted as whatever the defaultIconSize field variable has its constant
         value. iconSize will effect the layout of your view even if you pass a nil for your icon image. */
        self.iconSize = iconSize
        self.type = type

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

        switch type {
        case FormTextFieldType.normal:
            self.textField.keyboardType = .default
        case FormTextFieldType.email:
            self.textField.keyboardType = .emailAddress
        case FormTextFieldType.phone:
            self.textField.keyboardType = .phonePad
        case FormTextFieldType.password:
            self.textField.keyboardType = .default
            self.textField.isSecureTextEntry = true
        case FormTextFieldType.numerical:
            self.textField.keyboardType = .numberPad
        case FormTextFieldType.dropDown:
            print("DROPDOWN")
        case FormTextFieldType.dropDownDate:
            print("DROPDOWNDATE")
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
        view.backgroundColor = .divider
        return view
    }()
}

//For UITextField delegation.
extension FormTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.bottomLine.backgroundColor = self.tintColor
        self.delegate?.textFieldDidBeginEditing()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.bottomLine.backgroundColor = .divider
        self.delegate?.textFieldDidBeginEditing()
    }
}

//For turning the textfield into a DropDown menu.
extension FormTextFieldView {
    func setAsADropDownMenu(picker: UIPickerView? = nil, datePicker: UIDatePicker? = nil) {
        isADropDownMenu = true
        let dropDownIcon = UIImageView(image: #imageLiteral(resourceName: "drop-solid"))
        dropDownIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dropDownIcon)
        NSLayoutConstraint.activate([
                dropDownIcon.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
                dropDownIcon.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
                dropDownIcon.heightAnchor.constraint(equalToConstant: 10),
                dropDownIcon.widthAnchor.constraint(equalToConstant: 10)
            ])
    }
}

//For input validation.
extension FormTextFieldView {
    func hasValidInput() -> Bool{
        guard let text = self.textField.text else { return false }
        if text.isEmpty { return false }

        switch self.type! {
        case .normal:
            if !Regex.validateName(text: text) {
                return false
            }
        case .email:
            if !Regex.validateEmail(text: text) {
                return false
            }
        case .phone:
            if !Regex.onlyPhoneNumber(text: text) {
                return false
            }
        case .password:
            if !Regex.hasSpecialCharacter(text: text) || !Regex.hasLowerCase(text: text) ||
                !Regex.hasNumber(text: text) || !Regex.hasUpperCase(text: text) {
                return false
            }
        case .numerical:
            if !Regex.validatePostalCode(text: text) {
                return false
            }
        case .dropDown:
            //TODO: Validate.
            break
        case .dropDownDate:
            //TODO: Validate age.
            break
        }
        return true
    }
}
