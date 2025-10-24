//
//  PlacesView.swift
//  ABN-AMRO-iOS-Case
//
//  Created by Onur Kara on 24/10/2025.
//

import SwiftUI

struct PlacesView: View {
    
    @ObservedObject var viewModel: PlacesViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView(viewModel.loadingMessage)
                        .accessibilityLabel(viewModel.loadingAccessibilityLabel)
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(message: errorMessage)
                } else if viewModel.places.isEmpty {
                    emptyStateView
                } else {
                    placesList
                }
            }
            .navigationTitle(viewModel.navigationTitle)
            .task {
                await viewModel.fetchPlaces()
            }
        }
    }

    private var placesList: some View {
        List(viewModel.places) { place in
            PlaceRowView(place: place)
                .contentShape(Rectangle())
                .accessibilityElement(children: .combine)
                .accessibilityLabel(accessibilityLabel(place: place))
                .accessibilityHint(viewModel.wikipediaHint)
                .accessibilityAddTraits(.isButton)
        }
    }
    
    private var emptyStateView: some View {
        ContentUnavailableView(
            viewModel.noPlacesTitle,
            systemImage: "map",
            description: Text(viewModel.noPlacesDescription)
        )
        .accessibilityLabel(viewModel.noPlacesAccessibilityLabel)
    }
    
    private func errorView(message: String) -> some View {
        ContentUnavailableView(
            viewModel.errorTitle,
            systemImage: "exclamationmark.triangle",
            description: Text(message)
        )
        .accessibilityLabel("\(viewModel.errorTitle): \(message)")
    }

    private func accessibilityLabel(place: PlaceViewData) -> String {
        var label = "Location: \(place.name)"
        if let latitude = place.latitude, let longitude = place.longitude {
            label += ", Coordinates: Latitude \(String(format: "%.4f", latitude)), Longitude \(String(format: "%.4f", longitude))"
        }

        return label
    }
}

// MARK: - Preview

import PlacesDataProvider

#Preview {
    let mockRepository = MockFetchPlacesRepository()
    let viewModel = PlacesViewModel(repository: mockRepository)
    PlacesView(viewModel: viewModel)
}

final class MockFetchPlacesRepository: FetchPlacesRepositoryProtocol {
    func fetchPlaces() async -> Result<[PlacesDataProvider.Place], PlacesDataProvider.FetchPlacesError> {
        try? await Task.sleep(for: .seconds(1))
        
        let mockPlaces = [
            PlacesDataProvider.Place(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215),
            PlacesDataProvider.Place(name: "Mumbai", latitude: 19.0823998, longitude: 72.8111468),
            PlacesDataProvider.Place(name: "Copenhagen", latitude: 55.6713442, longitude: 12.523785),
            PlacesDataProvider.Place(name: nil, latitude: 40.4380638, longitude: -3.7495758)
        ]
        
        return .success(mockPlaces)
    }
}

