//
//  NetworkSessionable.swift
//
//
//  Created by Onur Kara on 24/10/2025.
//

import Foundation

public protocol NetworkSessionable: Sendable {

    func data(for url: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension NetworkSessionable {

    func data(for url: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: url, delegate: nil)
    }
}

extension URLSession: NetworkSessionable {}

