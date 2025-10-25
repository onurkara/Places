//
//  PlacesViewModel.swift
//  ABN-AMRO-iOS-Case
//
//  Created by Onur Kara on 24/10/2025.
//

import Combine
import Foundation
import PlacesDataProvider
import Util

final class PlacesViewModel: ObservableObject {

    private let repository: FetchPlacesRepositoryProtocol
    
    @Published var places: [PlaceViewData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    let navigationTitle = "Places"
    let loadingMessage = "Loading places..."
    let loadingAccessibilityLabel = "Loading places"
    let noPlacesTitle = "No Places Found"
    let noPlacesDescription = "There are no places to display at the moment."
    let noPlacesAccessibilityLabel = "No places found"
    let errorTitle = "Error"
    let wikipediaHint = "Double tap to open Wikipedia with this location"
    
    let alertButtonOK = "OK"
    let locationPrefix = "Location: "
    let coordinatesPrefix = ", Coordinates: Latitude "
    let longitudePrefix = ", Longitude "

    private let invalidPlaceInfoMessage = "This place info is not valid"
    private let invalidURLFormatMessage = "Invalid URL format"
    private let wikipediaURLFormat = "wikipedia://places?latitude=%@&longitude=%@"
        
    init(repository: FetchPlacesRepositoryProtocol) {
        self.repository = repository
    }

    @MainActor
    func fetchPlaces() async {
        isLoading = true
        errorMessage = nil
        
        let result = await repository.fetchPlaces()
        
        switch result {
        case .success(let fetchedPlaces):
            self.places = fetchedPlaces.map { PlaceViewData(place: $0) }
        case .failure(let error):
            self.errorMessage = error.message
        }
        
        isLoading = false
    }
    
    @MainActor
    func openWikipediaDeepLink(for place: PlaceViewData) {
        guard let latitude = place.latitude, let longitude = place.longitude else {
            showAlert(invalidPlaceInfoMessage)
            return
        }
        
        guard isValidCoordinates(latitude: latitude, longitude: longitude) else {
            showAlert(invalidPlaceInfoMessage)
            return
        }
        
        let wikipediaURLString = String(format: wikipediaURLFormat, "\(latitude)", "\(longitude)")
        
        guard let deepLinkHandler = DeepLinkHandler(urlString: wikipediaURLString) else {
            showAlert(invalidURLFormatMessage)
            return
        }
        
        let result = deepLinkHandler.open()
        switch result {
        case .success:
            break
        case .failure(let error):
            showAlert(error.localizedDescription)
        }
    }
    
    private func isValidCoordinates(latitude: Double, longitude: Double) -> Bool {
        let isLatitudeValid = latitude >= -90.0 && latitude <= 90.0
        let isLongitudeValid = longitude >= -180.0 && longitude <= 180.0
        
        // Also check that they are not exactly 0,0 which might indicate invalid/default data
        let isNotOriginPoint = !(latitude == 0.0 && longitude == 0.0)
        
        return isLatitudeValid && isLongitudeValid && isNotOriginPoint
    }
    
    private func showAlert(_ message: String) {
        alertMessage = message
        showAlert = true
    }
}
