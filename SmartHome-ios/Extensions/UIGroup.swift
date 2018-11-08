//
//  UIGroup.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

extension UIViewController {
    func activateHideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(UIViewController.dismissView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissView() {
        view.endEditing(true)
    }
}
