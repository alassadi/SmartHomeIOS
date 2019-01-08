//
//  SmartHomeAPI.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import Foundation

fileprivate let defaultHeaders = ["Content-Type":"application/json"]
fileprivate let path = Path()

struct APICreateAccount: RequestType {
    typealias ResponseType = [String:String]
    private let headers = defaultHeaders
    public let params: [String:Any]

    var data: RequestData {
        return RequestData(path: path.createUser,
                           method: .POST,
                           params: params,
                           headers: headers)
    }
}

struct APIRegisterUnit: RequestType {
    typealias ResponseType = [String:String]
    private let headers = defaultHeaders
    public let params: [String:Any]

    var data: RequestData {
        return RequestData(path: path.registerUnit,
                           method: .PUT,
                           params: params,
                           headers: headers)
    }
}

struct APIGetDevicesForRoom: RequestType {
    typealias ResponseType = [_device]
    private let headers = defaultHeaders
    public let roomId: String

    var data: RequestData {
        return RequestData(path: path.devicesFor(room: roomId),
                           method: .GET,
                           headers: headers)
    }
}
