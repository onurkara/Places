//
//  NetworkManager.swift
//
//
//  Created by Onur Kara on 24/10/2025.
//

import Foundation

public final class NetworkManager: NetworkManagerProtocol {

    private let session: NetworkSessionable
    private let decoder: JSONDecoder
    private let baseURL: String

    public init(session: NetworkSessionable = URLSession.shared,
                decoder: JSONDecoder = JSONDecoder(),
                baseURL: String) {
        self.session = session
        self.decoder = decoder
        self.baseURL = baseURL
    }

    public func send<T: Decodable>(request: any BaseRequest) async -> Result<T, NetworkError> {
        let requestURL = baseURL + request.path
        guard var urlComponent = URLComponents(string: requestURL) else {
            return .failure(NetworkError.invalidURL)
        }

        urlComponent.queryItems = request.requestUrlParameters()

        guard let url = urlComponent.url else {
            return .failure(NetworkError.invalidURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.requestBodyFrom()

        do {
            let (data,response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                return .failure(NetworkError.invalidStatusCode)
            }

            let apiResponse = try decoder.decode(T.self, from: data)
            return .success(apiResponse)
        } catch {
            return .failure(NetworkError.serverError)
        }
    }
}
