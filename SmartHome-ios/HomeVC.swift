//
//  HomeVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-19.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeVC: UIViewController {

    static var boxedStatus = Box(true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Add a Sync State UI

        initApp()
    }
    
    private func initApp() {
        DispatchQueue.main.async {
            //TODO: Check if already logged in

            if let currentUser = Auth.auth().currentUser {

                print(currentUser.email)
                print(currentUser.uid)

                let mainVC = MainVC()
                self.present(mainVC, animated: false)
            } else {
                let loginVC = LoginVC()
                self.present(loginVC, animated: false)
            }


        }
    }
}
