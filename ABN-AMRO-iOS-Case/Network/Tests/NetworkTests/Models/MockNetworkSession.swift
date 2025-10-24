//
//  MockNetworkSession.swift
//  
//
//  Created by Onur Kara on 24/10/2025.
//

import Foundation
@testable import Network

final class MockNetworkSession: NetworkSessionable {

    var result: (Data, URLResponse)?

    func data(for url: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        result!
    }
}
