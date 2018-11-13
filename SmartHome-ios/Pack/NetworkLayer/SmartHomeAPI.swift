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

//struct APICreateFriend: RequestType {
//    typealias ResponseType = friend
//    private let headers = defaultHeaders
//    public let params: [String:Any]
//
//    var data: RequestData {
//        return RequestData(path: path.createFriend,
//                           method: .POST,
//                           params: params,
//                           headers: headers)
//    }
//}

struct APIUpdateDevice: RequestType {
    typealias ResponseType = Bool
    private let headers = defaultHeaders
    public let params: [String:Any]

    var data: RequestData {
        return RequestData(path: path.updateDevice,
                           method: .POST,
                           params: params,
                           headers: headers)
    }
}

struct APIDeviceStatus: RequestType {
    typealias ResponseType = _device_status
    private let headers = defaultHeaders
    public let params: [String:String]

    var data: RequestData {
        return RequestData(path: path.deviceStatus,
                           method: .POST,
                           params: params,
                           headers: headers)
    }
}


