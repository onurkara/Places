import Testing
@testable import PlacesDataProvider

struct PlacesDataProviderTests {

    @Test("Fetch places successfully returns array of places")
    func fetchPlacesSuccess() async throws {
        let mockNetworkManager = MockNetworkManager()
        let expectedPlaces = [
            Place(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215),
            Place(name: "Mumbai", latitude: 19.0823998, longitude: 72.8111468),
            Place(name: "Copenhagen", latitude: 55.6713442, longitude: 12.523785)
        ]
        let response = GetPlacesResponse(places: expectedPlaces)
        mockNetworkManager.result = .success(response)

        let repository = FetchPlacesRepository(networkManager: mockNetworkManager)

        let result = await repository.fetchPlaces()

        switch result {
        case .success(let places):
            #expect(places.count == 3)
            #expect(places[0].name == "Amsterdam")
            #expect(places[0].latitude == 52.3547498)
            #expect(places[0].longitude == 4.8339215)
        case .failure:
            Issue.record("Expected success but got failure")
        }
    }

    @Test("Fetch places with missing name property")
    func fetchPlacesWithMissingName() async throws {
        let mockNetworkManager = MockNetworkManager()
        let expectedPlaces = [
            Place(name: nil, latitude: 40.4380638, longitude: -3.7495758)
        ]
        let response = GetPlacesResponse(places: expectedPlaces)
        mockNetworkManager.result = .success(response)

        let repository = FetchPlacesRepository(networkManager: mockNetworkManager)

        let result = await repository.fetchPlaces()

        switch result {
        case .success(let places):
            #expect(places.count == 1)
            #expect(places[0].name == nil)
            #expect(places[0].latitude == 40.4380638)
            #expect(places[0].longitude == -3.7495758)
        case .failure:
            Issue.record("Expected success but got failure")
        }
    }

    @Test("Fetch places returns empty array when no places available")
    func fetchPlacesEmptyArray() async throws {
        let mockNetworkManager = MockNetworkManager()
        let response = GetPlacesResponse(places: [])
        mockNetworkManager.result = .success(response)

        let repository = FetchPlacesRepository(networkManager: mockNetworkManager)

        let result = await repository.fetchPlaces()

        switch result {
        case .success(let places):
            #expect(places.isEmpty)
        case .failure:
            Issue.record("Expected success but got failure")
        }
    }

    @Test("Fetch places returns error when network request fails")
    func fetchPlacesNetworkError() async throws {
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(.invalidStatusCode)

        let repository = FetchPlacesRepository(networkManager: mockNetworkManager)

        let result = await repository.fetchPlaces()

        switch result {
        case .success:
            Issue.record("Expected failure but got success")
        case .failure(let error):
            #expect(error == .fetchPlacesFailed)
            #expect(error.message == "An error occured")
        }
    }

    @Test("Fetch places maps server error to fetch places error")
    func fetchPlacesServerError() async throws {
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(.serverError)

        let repository = FetchPlacesRepository(networkManager: mockNetworkManager)

        let result = await repository.fetchPlaces()

        switch result {
        case .success:
            Issue.record("Expected failure but got success")
        case .failure(let error):
            #expect(error == .fetchPlacesFailed)
        }
    }

    @Test("Fetch places maps invalid URL error to fetch places error")
    func fetchPlacesInvalidURLError() async throws {
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(.invalidURL)

        let repository = FetchPlacesRepository(networkManager: mockNetworkManager)

        let result = await repository.fetchPlaces()

        switch result {
        case .success:
            Issue.record("Expected failure but got success")
        case .failure(let error):
            #expect(error == .fetchPlacesFailed)
        }
    }


}
