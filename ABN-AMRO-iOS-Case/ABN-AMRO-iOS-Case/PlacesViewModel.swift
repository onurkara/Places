//
//  PlacesViewModel.swift
//  ABN-AMRO-iOS-Case
//
//  Created by Onur Kara on 24/10/2025.
//

import Foundation
import PlacesDataProvider
import Combine

final class PlacesViewModel: ObservableObject {

    private let repository: FetchPlacesRepositoryProtocol
    
    @Published var places: [PlaceViewData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    let navigationTitle = "Places"
    let loadingMessage = "Loading places..."
    let loadingAccessibilityLabel = "Loading places"
    let noPlacesTitle = "No Places Found"
    let noPlacesDescription = "There are no places to display at the moment."
    let noPlacesAccessibilityLabel = "No places found"
    let errorTitle = "Error"
    let wikipediaHint = "Double tap to open Wikipedia with this location"
        
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
}
