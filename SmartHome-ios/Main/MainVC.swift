//
//  MainVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-11.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit
import FirebaseAuth
import SnapKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.sideMenuVC.view)
        self.scrollView.addSubview(self.mainTabBarVC.view)

        self.sideMenuVC.didMove(toParent: self)
        self.mainTabBarVC.didMove(toParent: self)

        self.scrollView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalTo(self.view)
        }

        self.sideMenuVC.view.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.height.equalTo(self.scrollView.snp.height)
            make.width.equalTo(UIScreen.main.bounds.width*0.8)
        }

        self.mainTabBarVC.view.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(self.sideMenuVC.view.snp.trailing)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }

    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true
        view.bounces = false
        return view
    }()

    let sideMenuVC = SideMenuVC()
    let mainTabBarVC = MainTabBarVC()
}
