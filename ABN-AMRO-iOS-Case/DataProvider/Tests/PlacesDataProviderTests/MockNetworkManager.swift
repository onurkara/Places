//
//  MockNetworkManager.swift
//  DataProvider
//
//  Created by Onur Kara on 24/10/2025.
//

import Network

final class MockNetworkManager: NetworkManagerProtocol {
    var result: Result<Any, NetworkError>?

    func send<T: Decodable>(request: any BaseRequest) async -> Result<T, NetworkError> {
        guard let result = result else {
            return .failure(.invalidURL)
        }

        switch result {
        case .success(let value):
            if let typedValue = value as? T {
                return .success(typedValue)
            }
            return .failure(.serverError)
        case .failure(let error):
            return .failure(error)
        }
    }
}
