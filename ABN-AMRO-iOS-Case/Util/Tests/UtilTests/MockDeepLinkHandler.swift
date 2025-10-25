//
//  MockDeepLinkHandler.swift
//  Util
//
//  Created by Onur Kara on 25/10/2025.
//

import Foundation
@testable import Util

@MainActor
final class MockDeepLinkHandler: @MainActor DeepLinkHandlerProtocol {
    let url: URL
    var canOpenResult = true
    var openCalled = false

    init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            return nil
        }
        self.url = url
    }

    func canOpen() -> Bool {
        canOpenResult
    }

    func open() -> Result<Void, DeepLinkError> {
        openCalled = true
        guard canOpen() else {
            return .failure(.cannotOpen)
        }
        return .success(())
    }
}
