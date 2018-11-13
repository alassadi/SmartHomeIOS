//
//  Models.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import Foundation

struct friend: Codable {
    var _id: String?
    var name: String?
    var surname: String?
    var description: String?
    var __v: Int?
}

struct _user: Codable {
    let id: Int32?
    let email: String?
    var first_name: String?
    var last_name: String?
    var phone: String?
    var address: String?
    var postal_code: String?
    var city: String?
    var country: String?
    var date_of_birth: String?
    var gender: String?
}

struct _device_status: Codable {
    let enabled: Bool?
    let name: String?
    let room_id: String?
    let version: Double?
}
