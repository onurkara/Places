//
//  MockResponseGenerator.swift
//
//
//  Created by Onur Kara on 24/10/2025.
//

import Foundation

enum MockResponseGenerator {

    static func generateInvalidStatusCode() ->  (Data, URLResponse) {
        guard let url = URL(string: "www.example.com"),
              let response = HTTPURLResponse(url: url,
                                             statusCode: 401,
                                             httpVersion: nil,
                                             headerFields: nil) else {
            fatalError("Url or response should not be empty!")
        }

        return (Data(), response)
    }

    static func generateDecodeErrorResponse() ->  (Data, URLResponse) {
        guard let url = URL(string: "www.example.com"),
              let response = HTTPURLResponse(url: url,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil) else {
            fatalError("Url or response should not be empty!")
        }

        return (Data(), response)
    }

    static func generateSuccededUserResponse() -> (Data, URLResponse) {
        guard let url = URL(string: "www.example.com"),
              let response = HTTPURLResponse(url: url,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil),
              let data = MockResponseGenerator.mockUserData() else {
            fatalError("Url, response and data should not be empty!")
        }

        return (data, response)
    }

    static func mockUserData() -> Data? {
        let mockUserData = """
           {
               "id": 1,
               "name": "User"
           }
           """.data(using: .utf8)

        return mockUserData
    }
}
