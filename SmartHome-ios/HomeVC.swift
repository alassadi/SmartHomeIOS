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
        //TODO: Add a Sync State UI

        initApp()
    }
    
    private func initApp() {
        DispatchQueue.main.async {
            //TODO: Check if already logged in
            let loginVC = LoginVC()
            self.present(loginVC, animated: false)
        }
    }
}
