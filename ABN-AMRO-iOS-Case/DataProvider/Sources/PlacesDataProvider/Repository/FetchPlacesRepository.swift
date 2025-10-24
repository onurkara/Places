//
//  FetchPlacesRepository.swift
//  DataProvider
//
//  Created by Onur Kara on 24/10/2025.
//

import Network

public final class FetchPlacesRepository: FetchPlacesRepositoryProtocol {

    private let networkManager: NetworkManagerProtocol

    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    public func fetchPlaces() async -> Result<[Place], FetchPlacesError> {
        let result: Result<GetPlacesResponse, NetworkError> = await networkManager.send(request: GetPlacesRequest())
        switch result {
        case .success(let response):
            return .success(response.places)
        case .failure(_):
            return .failure(.fetchPlacesFailed)
        }
    }
}
