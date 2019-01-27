//
//  MainVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-11.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseMessaging
import SnapKit

class MainVC: UIViewController {

    static var sideMenuOpen = Box<Bool>.init(false)

    override func viewDidLoad() {
        self.view.backgroundColor = .white

        Messaging.messaging().subscribe(toTopic: "deviceUpdate") { error in
            print("Subscribed to device update")
        }

        self.scrollView.delegate = self

        MainVC.sideMenuOpen.bind { (isOpen) in
            if isOpen {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
            } else {
                self.scrollView.setContentOffset(CGPoint(x:UIScreen.main.bounds.width*0.8, y:0), animated: true)
            }
        }

        self.sideMenuVC.delegate = self

        setConstraints()
    }

    private func setConstraints() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.sideMenuVC.view)
        self.scrollView.addSubview(self.mainTabBarVC.view)
        self.scrollView.addSubview(self.shadeView)

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

        self.shadeView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalTo(self.mainTabBarVC.view)
        }
    }

    private func onLogOutPressed() {
        do {
            try Auth.auth().signOut()
            Messaging.messaging().unsubscribe(fromTopic: "deviceUpdate") { error in
                print("unscribed from topic deviceUpdate")
            }
            UserDefaults.standard.reset()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginVC()
        } catch {
            print("Couldn't log out")
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.setContentOffset(CGPoint(x:UIScreen.main.bounds.width*0.8, y:0), animated: false)
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

    let shadeView: UIView = { //TODO: Shade
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()

    let sideMenuVC = SideMenuVC()
    let mainTabBarVC = MainTabBarVC()
}

extension MainVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sideMenuWidth = UIScreen.main.bounds.width*0.8
        let xValue = ["shadeValue":scrollView.contentOffset.x/sideMenuWidth]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidScroll"),
                                        object: nil,
                                        userInfo: xValue)
        self.shadeView.alpha = -scrollView.contentOffset.x/(sideMenuWidth*2) + 1/2
    }
}

extension MainVC: SideMenuVCDelegate {
    func sideMenuVC(didSelect rowAt: Int) {
        switch rowAt {
        case 0:
            MainTabBarVC.selectedIndex.value = 0
            MainVC.sideMenuOpen.value = false
        case 1:
            MainTabBarVC.selectedIndex.value = 1
            MainVC.sideMenuOpen.value = false
        case 2:
            let aboutVC = UINavigationController(rootViewController: AboutVC())
            self.present(aboutVC, animated: true)
            MainVC.sideMenuOpen.value = true
        case 3:
            self.onLogOutPressed()
        default:
            print("Something went horribly wrong.")
        }
    }
}
