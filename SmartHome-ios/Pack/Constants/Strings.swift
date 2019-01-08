//
//  Strings.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-11.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import Foundation

struct NotificationName {
    static let FCM_TOKEN_RECEIVED = "FCM_TOKEN_RECEIVED"
}

enum DeviceType: String {
    //Wow...
    case temperatureUpstairs = "temperature upstairs"
    case temperatureInside = "temperature inside"
    case temperatureOutside = "temperature outside"
    case lampOutside = "lamp outside"
    case lampInside = "lamp inside"
    case burglarAlarm = "burglar alarm"
    case fireALarm = "fire alarm"
    case waterLeak = "water leak"
    case door = "door"
    case window = "window"
    case stove = "stove"
    case radiator = "radiator"
}

struct FontNames {
    static let FAPro_solid = "FontAwesome5ProSolid"
}
