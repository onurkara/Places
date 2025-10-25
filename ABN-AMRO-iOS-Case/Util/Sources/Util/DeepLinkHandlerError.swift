//
//  DeepLinkHandlerError.swift
//  ABN-AMRO-iOS-Case
//
//  Created by Onur Kara on 25/10/2025.
//

public enum DeepLinkError: Error, Equatable {
    case cannotOpen

    public var localizedDescription: String {
        switch self {
        case .cannotOpen:
            return "An error occurred"
        }
    }
}
