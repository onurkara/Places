//
//  FetchPlacesRepositoryProtocol.swift
//  DataProvider
//
//  Created by Onur Kara on 24/10/2025.
//

public protocol FetchPlacesRepositoryProtocol: Sendable {

    func fetchPlaces() async -> Result<[Place], FetchPlacesError>
}

