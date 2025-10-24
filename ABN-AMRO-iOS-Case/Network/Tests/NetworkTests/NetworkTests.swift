import Testing
@testable import Network

struct NetworkTests {

    @Test("Status code error is returned for invalid status code")
    func statusCodeError() async throws {
        let networkSession = MockNetworkSession()
        let networkManager = NetworkManager(session: networkSession,
                                            baseURL: "www.example.com")
        
        let request = MockRequestGenerator.successfullUrlGetRequest()
        networkSession.result = MockResponseGenerator.generateInvalidStatusCode()

        let result: Result<MockUser, NetworkError> = await networkManager.send(request: request)
        switch result {
        case .success:
            Issue.record("Result should not be succeeded")
        case .failure(let error):
            #expect(error == NetworkError.invalidStatusCode)
        }
    }

    @Test("Server error is returned for decode error")
    func serverError() async throws {
        let networkSession = MockNetworkSession()
        let networkManager = NetworkManager(session: networkSession,
                                            baseURL: "www.example.com")
        
        let request = MockRequestGenerator.successfullUrlGetRequest()
        networkSession.result = MockResponseGenerator.generateDecodeErrorResponse()

        let result: Result<MockUser, NetworkError> = await networkManager.send(request: request)
        switch result {
        case .success:
            Issue.record("Result should not be succeeded")
        case .failure(let error):
            #expect(error == NetworkError.serverError)
        }
    }

    @Test("Valid user ID is decoded correctly")
    func validUserIdDecoded() async throws {
        let networkSession = MockNetworkSession()
        let networkManager = NetworkManager(session: networkSession,
                                            baseURL: "www.example.com")
        
        let request = MockRequestGenerator.successfullUrlPostRequest()
        networkSession.result = MockResponseGenerator.generateSuccededUserResponse()

        let result: Result<MockUser, NetworkError> = await networkManager.send(request: request)
        switch result {
        case .success(let mockUser):
            #expect(mockUser.id == 1)
        case .failure:
            Issue.record("Result should not fail")
        }
    }

    @Test("Valid user name is decoded correctly")
    func validUserNameDecoded() async throws {
        let networkSession = MockNetworkSession()
        let networkManager = NetworkManager(session: networkSession,
                                            baseURL: "www.example.com")
        
        let request = MockRequestGenerator.successfullUrlPostRequest()
        networkSession.result = MockResponseGenerator.generateSuccededUserResponse()

        let result: Result<MockUser, NetworkError> = await networkManager.send(request: request)
        switch result {
        case .success(let mockUser):
            #expect(mockUser.name == "User")
        case .failure:
            Issue.record("Result should not fail")
        }
    }
}
