//
//  FetchPlacesError.swift
//  DataProvider
//
//  Created by Onur Kara on 24/10/2025.
//

public enum FetchPlacesError: Error {

    case fetchPlacesFailed

    public var message: String {
        switch self {
        case .fetchPlacesFailed:
            "An error occured"
        }
    }
}
