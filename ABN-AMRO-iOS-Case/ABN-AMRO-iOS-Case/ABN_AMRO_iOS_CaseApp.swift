//
//  ABN_AMRO_iOS_CaseApp.swift
//  ABN-AMRO-iOS-Case
//
//  Created by Onur Kara on 24/10/2025.
//

import Network
import SwiftUI
import PlacesDataProvider

@main
struct ABN_AMRO_iOS_CaseApp: App {
    var body: some Scene {
        WindowGroup {
            PlacesView(viewModel: createViewModel())
        }
    }

    private func createViewModel() -> PlacesViewModel {
        let networkManager = NetworkManager(baseURL: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/")
        let repository = FetchPlacesRepository(networkManager: networkManager)
        return PlacesViewModel(repository: repository)
    }
}
