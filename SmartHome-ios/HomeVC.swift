//
//  HomeVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-19.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    static var boxedStatus = Box(true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Add a Sync State UI

        APIDeviceStatus(params: ["id":"my9iXu6WvEgx5oNLLegs"]).execute(onSuccess: { (device_status) in
            if let status = device_status.enabled {
                HomeVC.boxedStatus.value = status
            }
        }) { (error) in
            print(error)
        }

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
