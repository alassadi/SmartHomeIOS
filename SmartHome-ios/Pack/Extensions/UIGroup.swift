//
//  UIGroup.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

extension UIColor {
    static let divider: UIColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
    static let highlight: UIColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    static let lighterBlack: UIColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
    static let redish: UIColor = UIColor(red: 214/255, green: 91/255, blue: 58/255, alpha: 1.0)
}

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
    func presentAlert(title: String?, message: String?, handler: (()->())? = nil) {
        var alertController : UIAlertController = UIAlertController.init()
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { //Localize
            (action) in handler?()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    func presentAlertWithOptions(title: String?, message: String?, prefferedStyle: UIAlertController.Style, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: prefferedStyle)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
}
