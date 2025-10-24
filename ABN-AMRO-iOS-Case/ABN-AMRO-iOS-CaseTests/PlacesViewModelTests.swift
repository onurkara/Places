//
//  PlacesViewModelTests.swift
//  ABN-AMRO-iOS-PlacesViewModelTests
//
//  Created by Onur Kara on 24/10/2025.
//

import Testing
import PlacesDataProvider
@testable import ABN_AMRO_iOS_Case

struct PlacesViewModelTests {
    
    @Test("Fetch places successfully updates places array")
    @MainActor
    func fetchPlacesSuccess() async throws {
        let mockRepository = MockFetchPlacesRepository()
        let expectedPlaces = [
            Place(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215),
            Place(name: "Mumbai", latitude: 19.0823998, longitude: 72.8111468),
            Place(name: "Copenhagen", latitude: 55.6713442, longitude: 12.523785)
        ]
        mockRepository.result = .success(expectedPlaces)
        
        let viewModel = PlacesViewModel(repository: mockRepository)
        
        await viewModel.fetchPlaces()
        
        #expect(mockRepository.fetchPlacesCalled)
        #expect(viewModel.places.count == 3)
        #expect(viewModel.places[0].name == "Amsterdam")
        #expect(viewModel.places[0].latitude == 52.3547498)
        #expect(viewModel.places[0].longitude == 4.8339215)
        #expect(viewModel.places[1].name == "Mumbai")
        #expect(viewModel.places[2].name == "Copenhagen")
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test("Fetch places with missing name uses default")
    @MainActor
    func fetchPlacesWithMissingName() async throws {
        let mockRepository = MockFetchPlacesRepository()
        let expectedPlaces = [
            Place(name: nil, latitude: 40.4380638, longitude: -3.7495758)
        ]
        mockRepository.result = .success(expectedPlaces)
        
        let viewModel = PlacesViewModel(repository: mockRepository)
        
        await viewModel.fetchPlaces()
        
        #expect(viewModel.places.count == 1)
        #expect(viewModel.places[0].name == "Unknown Location")
        #expect(viewModel.places[0].latitude == 40.4380638)
        #expect(viewModel.places[0].longitude == -3.7495758)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test("Fetch places with empty array returns empty places")
    @MainActor
    func fetchPlacesEmptyArray() async throws {
        let mockRepository = MockFetchPlacesRepository()
        mockRepository.result = .success([])
        
        let viewModel = PlacesViewModel(repository: mockRepository)
        
        await viewModel.fetchPlaces()
        
        #expect(viewModel.places.isEmpty)
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.isLoading == false)
    }
    
    @Test("Fetch places failure sets error message")
    @MainActor
    func fetchPlacesFailure() async throws {
        let mockRepository = MockFetchPlacesRepository()
        mockRepository.result = .failure(.fetchPlacesFailed)
        
        let viewModel = PlacesViewModel(repository: mockRepository)
        
        await viewModel.fetchPlaces()
        
        #expect(mockRepository.fetchPlacesCalled)
        #expect(viewModel.places.isEmpty)
        #expect(viewModel.errorMessage == "An error occured")
        #expect(viewModel.isLoading == false)
    }
    
    @Test("Loading state is true during fetch")
    @MainActor
    func loadingStateDuringFetch() async throws {
        let mockRepository = MockFetchPlacesRepository()
        let expectedPlaces = [
            Place(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
        ]
        mockRepository.result = .success(expectedPlaces)
        
        let viewModel = PlacesViewModel(repository: mockRepository)
        
        #expect(viewModel.isLoading == false)
        
        await viewModel.fetchPlaces()
        
        #expect(viewModel.isLoading == false)
    }
    
    @Test("Error message is cleared on new fetch")
    @MainActor
    func errorMessageClearedOnNewFetch() async throws {
        let mockRepository = MockFetchPlacesRepository()
        mockRepository.result = .failure(.fetchPlacesFailed)
        
        let viewModel = PlacesViewModel(repository: mockRepository)
        
        await viewModel.fetchPlaces()
        #expect(viewModel.errorMessage == "An error occured")
        
        mockRepository.result = .success([
            Place(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
        ])
        await viewModel.fetchPlaces()
        
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.places.count == 1)
    }
    
    @Test("PlaceViewData coordinates formatting")
    @MainActor
    func placeViewDataCoordinatesFormatting() async throws {
        let mockRepository = MockFetchPlacesRepository()
        let expectedPlaces = [
            Place(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215),
            Place(name: "Test", latitude: nil, longitude: nil)
        ]
        mockRepository.result = .success(expectedPlaces)
        
        let viewModel = PlacesViewModel(repository: mockRepository)
        
        await viewModel.fetchPlaces()
        
        #expect(viewModel.places[0].coordinates == "Lat: 52.3547, Long: 4.8339")
        #expect(viewModel.places[1].coordinates == "Coordinates unavailable")
    }
    
    @Test("Multiple fetches update places correctly")
    @MainActor
    func multipleFetchesUpdatePlaces() async throws {
        let mockRepository = MockFetchPlacesRepository()
        let viewModel = PlacesViewModel(repository: mockRepository)
        
        mockRepository.result = .success([
            Place(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
        ])
        await viewModel.fetchPlaces()
        #expect(viewModel.places.count == 1)
        
        mockRepository.result = .success([
            Place(name: "Mumbai", latitude: 19.0823998, longitude: 72.8111468),
            Place(name: "Copenhagen", latitude: 55.6713442, longitude: 12.523785)
        ])
        await viewModel.fetchPlaces()
        
        #expect(viewModel.places.count == 2)
        #expect(viewModel.places[0].name == "Mumbai")
        #expect(viewModel.places[1].name == "Copenhagen")
    }
}

