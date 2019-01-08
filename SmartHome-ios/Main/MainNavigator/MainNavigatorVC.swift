//
//  MainNavigator.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-12.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        self.viewControllers = [self.dashboardVC, self.roomsVC].map({
            UINavigationController(rootViewController: $0)
        })
    }

    let dashboardVC: DashboardVC = {
        let vc = DashboardVC()
        vc.title = "Dashboard" //Todo: Localize
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "dashboard"), tag: 0)
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }()

    let roomsVC: RoomListVC = {
        let vc = RoomListVC()
        vc.title = "Rooms" //Todo: Localize
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "house"), tag: 1)
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }()
}

