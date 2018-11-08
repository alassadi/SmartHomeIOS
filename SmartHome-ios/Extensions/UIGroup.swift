//
//  UIGroup.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

extension UIViewController {
    func setHideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func setButtonsForPlainNavigationBarStyle(with tintColor: UIColor) {
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-cancel"), style: .plain, target: self, action: #selector(self.dismissSelf))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icon-back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon-back")
        self.navigationController?.navigationBar.tintColor = tintColor
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
}
