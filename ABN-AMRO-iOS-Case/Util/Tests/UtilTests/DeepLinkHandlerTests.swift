import Testing
import Foundation
@testable import Util

@MainActor
struct DeepLinkHandlerTests {
    
    @Test("DeepLinkHandler is created successfully with valid URL string")
    func testInitWithValidURL() throws {
        let handler = DeepLinkHandler(urlString: "https://example.com")
        #expect(handler != nil)
        #expect(handler?.url.absoluteString == "https://example.com")
    }
    
    @Test("DeepLinkHandler returns success when URL can be opened")
    func testMockHandlerSuccess() throws {
        let mockHandler = try #require(MockDeepLinkHandler(urlString: "wikipedia://places"))
        mockHandler.canOpenResult = true
        
        let result = mockHandler.open()
        
        switch result {
        case .success:
            #expect(mockHandler.openCalled == true)
        case .failure:
            #expect(Bool(false), "Expected success but got failure")
        }
    }
    
    @Test("DeepLinkHandler returns cannotOpen error when URL cannot be opened")
    func testMockHandlerFailure() throws {
        let mockHandler = try #require(MockDeepLinkHandler(urlString: "wikipedia://places"))
        mockHandler.canOpenResult = false
        
        let result = mockHandler.open()
        
        switch result {
        case .success:
            #expect(Bool(false), "Expected failure but got success")
        case .failure(let error):
            #expect(error == .cannotOpen)
            #expect(mockHandler.openCalled == true)
        }
    }
}
