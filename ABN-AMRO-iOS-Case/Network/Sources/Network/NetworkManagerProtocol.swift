//
//  NetworkManagerProtocol.swift
//
//  Created by Onur Kara on 24/10/2025.
//

public protocol NetworkManagerProtocol {

    func send<T: Decodable>(request: any BaseRequest) async -> Result<T, NetworkError>
}
