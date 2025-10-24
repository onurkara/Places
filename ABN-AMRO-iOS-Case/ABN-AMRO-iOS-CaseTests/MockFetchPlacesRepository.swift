//
//  MockFetchPlacesRepository.swift
//  ABN-AMRO-iOS-Case
//
//  Created by Onur Kara on 24/10/2025.
//

import PlacesDataProvider

final class MockFetchPlacesRepository: FetchPlacesRepositoryProtocol {
    nonisolated(unsafe) var result: Result<[Place], FetchPlacesError>?
    nonisolated(unsafe) var fetchPlacesCalled = false

    func fetchPlaces() async -> Result<[Place], FetchPlacesError> {
        fetchPlacesCalled = true
        return result ?? .failure(.fetchPlacesFailed)
    }
}
