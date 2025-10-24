//
//  MockRequestGenerator.swift
//
//
//  Created by Onur Kara on 24/10/2025.
//

import Foundation

enum MockRequestGenerator {

    static func successfullUrlGetRequest() -> MockRequest {
        MockRequest(path: "users", method: .get)
    }
    static func successfullUrlPostRequest() -> MockRequest {
        MockRequest(path: "user", method: .post, body: MockUser(id: 1, name: "onur"))
    }
}
