//
//  RequestData.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import Foundation

public struct RequestData {
    public let path: String
    public let method: HTTPMethod
    public let params: [String:Any?]?
    public let headers: [String:String]?
    public let additionalHeaders: [String:String]?
    public let noAuth: Bool

    public init (path: String,
                 method: HTTPMethod = .GET,
                 params: [String:Any?]? = nil,
                 headers: [String:String]? = nil,
                 additionalHeaders: [String:String]? = nil,
                 noAuth: Bool = false) {

        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
        self.additionalHeaders = additionalHeaders
        self.noAuth = noAuth
    }
}

public protocol RequestType {
    associatedtype ResponseType: Codable
    var data: RequestData { get }
}

public protocol NetworkDispatcher {
    func dispatch(request: RequestData,
                  onSuccess: @escaping (Data) -> Void,
                  onError: @escaping (Error) -> Void)
}
