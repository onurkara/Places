//
//  BaseRequest.swift
//
//
//  Created by Onur Kara on 24/10/2025.
//

import Foundation

public protocol BaseRequest {

    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
    var queryParams: [String: String]? { get }
}

public extension BaseRequest {

    var headers: [String: String] { return ["Content-Type":"application/json"] }
    var body: Encodable? { return nil }
    var queryParams: [String: String]? { return nil }
}

extension BaseRequest {

    func requestBodyFrom() -> Data? {
        guard let body = body,
              let httpBody = try? JSONEncoder().encode(body) else {
            return nil
        }

        return httpBody
    }

    func requestUrlParameters() -> [URLQueryItem]? {
        guard let queryParams else {
            return nil
        }

        return queryParams.map { key, value in
            URLQueryItem(name: key, value: value)
        }
    }
}
