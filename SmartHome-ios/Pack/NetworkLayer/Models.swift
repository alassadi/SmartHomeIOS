//
//  Models.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import Foundation

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

struct _device: Codable {
    let id: String?
    let room_id: String?
    let name: String?
    var value: String?

    init(id: String? = nil, room_id: String? = nil, name: String? = nil, value: String?) {
        self.id = id
        self.room_id = room_id
        self.name = name
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        room_id = try container.decode(String.self, forKey: .room_id)
        name = try container.decode(String.self, forKey: .name)
        if let data = try? container.decode(Int.self, forKey: .value) {
            value = String(data)
        } else if let data = try? container.decode(Bool.self, forKey: .value) {
            value = String(data)
        } else {
            value = try container.decode(String.self, forKey: .value)
        }
    }
}
