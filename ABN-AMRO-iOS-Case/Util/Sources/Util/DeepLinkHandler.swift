//
//  DeepLinkHandler.swift
//  ABN-AMRO-iOS-Case
//
//  Created by Onur Kara on 25/10/2025.
//

import Foundation
import UIKit

public struct DeepLinkHandler: DeepLinkHandlerProtocol {

    public let url: URL
    
    public init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            return nil
        }
        self.url = url
    }

    @MainActor
    public func open() -> Result<Void, DeepLinkError> {
        guard canOpen() else {
            return .failure(.cannotOpen)
        }
        UIApplication.shared.open(url)
        return .success(())
    }

    @MainActor
    public func canOpen() -> Bool {
        UIApplication.shared.canOpenURL(url)
    }
}
