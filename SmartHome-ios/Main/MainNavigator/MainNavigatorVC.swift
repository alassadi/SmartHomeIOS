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
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        vc.title = "Dashboard" //Todo: Localize
        return vc
    }()

    let roomsVC: RoomListVC = {
        let vc = RoomListVC()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        vc.title = "Rooms" //Todo: Localize
        return vc
    }()
}

