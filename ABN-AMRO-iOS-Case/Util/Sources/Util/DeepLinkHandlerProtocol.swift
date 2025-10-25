//
//  DeepLinkHandlerProtocol.swift
//  ABN-AMRO-iOS-Case
//
//  Created by Onur Kara on 25/10/2025.
//

import Foundation

public protocol DeepLinkHandlerProtocol {
    var url: URL { get }
    
    init?(urlString: String)
    
    @MainActor
    func open() -> Result<Void, DeepLinkError>
    @MainActor
    func canOpen() -> Bool
}
