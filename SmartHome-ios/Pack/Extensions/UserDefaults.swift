//
//  UserDefaults.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2019-01-06.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum UserDefaultKeys: String {
        case email
        case appUserId
        case fcmToken
    }

    func setAppUserId(id: String) {
        set(id, forKey: UserDefaultKeys.appUserId.rawValue)
    }

    func setLoggedInUser(email: String){
        set(email, forKey: UserDefaultKeys.email.rawValue)
    }

    func setFCMToken(token: String) {
        set(token, forKey: UserDefaultKeys.fcmToken.rawValue)
    }

    func getAppUserId() -> String? {
        return string(forKey: UserDefaultKeys.appUserId.rawValue)
    }

    func getLoggedInUser() -> String? {
        return string(forKey: UserDefaultKeys.email.rawValue)
    }

    func getFCMToken() -> String? {
        return string(forKey: UserDefaultKeys.fcmToken.rawValue)
    }

    func reset() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
}
