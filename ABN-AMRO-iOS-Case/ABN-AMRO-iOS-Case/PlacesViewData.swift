//
//  PlacesViewData.swift
//  ABN-AMRO-iOS-Case
//
//  Created by Onur Kara on 24/10/2025.
//

import Foundation
import PlacesDataProvider

struct PlaceViewData: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double?
    let longitude: Double?

    init(place: Place) {
        self.name = place.name ?? "Unknown Location"
        self.latitude = place.latitude
        self.longitude = place.longitude
    }

    var coordinates: String {
        guard let lat = latitude, let lon = longitude else {
            return "Coordinates unavailable"
        }
        return "Lat: \(String(format: "%.4f", lat)), Long: \(String(format: "%.4f", lon))"
    }
}

