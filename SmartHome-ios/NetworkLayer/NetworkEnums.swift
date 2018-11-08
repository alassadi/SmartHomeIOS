//
//  NetworkEnums.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

let baseUrl = "http://52.15.234.144:3000"

public enum HTTPMethod : String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public enum ConnError: Swift.Error {
    case invalidUrl
    case noData
    case unauthorized
    case badRequest
    case failure
    case noConnection
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

struct Path {
    public let base = baseUrl
    public let createFriend = "\(baseUrl)/friends"
    public func getFriend(with id: String) -> String {
        return "\(baseUrl)/friends/\(id)"
    }
}

public func configuredHeaders(additionalHeaders: [String:String]?, headers: [String:String]) -> [String:String] {
    if let _additionalHeaders = additionalHeaders {
        return headers.merged(with: _additionalHeaders)
    } else {
        return headers
    }
}
