//
//  SideMenuVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-12.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit
import FirebaseAuth

class SideMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.setConstraints()
        self.initTargets()
    }

    private func setConstraints() {
        self.view.addSubview(logOutButton)

        logOutButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
        }
    }

    private func initTargets() {
        logOutButton.addTarget(self, action: #selector(onLogOutPressed), for: .touchUpInside)
    }

    @objc func onLogOutPressed() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.reset()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginVC()
        } catch {
            print("Couldn't log out")
        }
    }

    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log out", for: .normal) //Localize
        button.setTitleColor(.red, for: .normal)
        button.isEnabled = true
        return button
    }()
}

//UserDefaults.standard.setIsLoggedIn(value: false)
//UserDefaults.standard.setLoggedInUser(username: "")
//
//guard let instance = instance else {
//    let controller = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
//    DispatchQueue.main.async {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = controller
//    }
//    CoreDataManager.shared.initCoreDataPersistanceContainer()
//    Log.i("instance is nil")
//    return
//}
//
//if let deviceId = UIDevice.current.identifierForVendor?.uuidString {
//    DeleteFCMTokenFromRemoteDatabase(deviceId: deviceId).execute(onSuccess: { (response) in
//        Log.s("Delete FCM token from remote DB.")
//    }) { (error, _error) in
//        Log.w(error)
//    }
//}
//
//let vc = UIApplication.shared.keyWindow?.rootViewController
//if vc is SignInVC {
//    instance.performSegue(withIdentifier: "unwindToSign", sender: nil)
//    CoreDataManager.shared.initCoreDataPersistanceContainer()
//} else {
//    SignInHelper.performLoginCheck()
//}
