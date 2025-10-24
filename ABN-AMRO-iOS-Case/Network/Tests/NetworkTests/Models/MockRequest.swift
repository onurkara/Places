//
//  MockRequest.swift
//  
//
//  Created by Onur Kara on 24/10/2025.
//

import Network

struct MockRequest: BaseRequest {

    var path: String
    var method: HTTPMethod
    var queryParams: [String : String]?
    var body: Codable?

    init(path: String = "path",
         method: HTTPMethod,
         body: Codable? = nil,
         queryParams: [String : String]? = nil) {
        self.path = path
        self.method = method
        self.queryParams = queryParams
        self.body = body
    }
}
