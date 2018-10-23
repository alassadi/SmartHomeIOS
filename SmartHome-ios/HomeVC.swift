//
//  HomeVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-19.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    private func initUI() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.view.addSubview(self.loginVC.view)
            NSLayoutConstraint.activate([
                self.loginVC.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.loginVC.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                self.loginVC.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                self.loginVC.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
                ])
        }
    }
    
    let loginVC = LoginVC()
}
