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
    static let blackish: UIColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
    static let redish: UIColor = UIColor(red: 214/255, green: 91/255, blue: 58/255, alpha: 1.0)
    static let yellowish: UIColor = UIColor(red: 254/255, green: 226/255, blue: 56/255, alpha: 1.0)
}

extension UIButton {
    public func setAsLoading(_ set: Bool, with indicatorColor: UIColor? = nil) {
        var isAlreadyLoading = false
        var indicatorView: UIActivityIndicatorView?

        for view in self.subviews {
            if view.restorationIdentifier == "indicator" {
                isAlreadyLoading = true
                indicatorView = view as? UIActivityIndicatorView
            }
        }

        if set {
            if !isAlreadyLoading {
                let indicator: UIActivityIndicatorView = {
                    let view = UIActivityIndicatorView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.color = indicatorColor
                    view.startAnimating()
                    view.isHidden = false
                    view.restorationIdentifier = "indicator"
                    view.alpha = 1.0
                    return view
                }()
                self.addSubview(indicator)
                self.bringSubviewToFront(indicator)
                NSLayoutConstraint.activate([
                    indicator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    indicator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    indicator.topAnchor.constraint(equalTo: self.topAnchor),
                    indicator.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                    ])
                self.isEnabled = false
                self.setTitleColor(self.titleColor(for: .normal)?.withAlphaComponent(0.0), for: .normal)
            } else {
                //It is already loading.
                //Check the color and thats all.
                indicatorView?.color = indicatorColor
            }
        } else {
            indicatorView?.alpha = 0.0
            indicatorView?.removeFromSuperview()
            self.setTitleColor(self.titleColor(for: .normal)?.withAlphaComponent(1.0), for: .normal)
            self.isEnabled = true
        }
    }
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
