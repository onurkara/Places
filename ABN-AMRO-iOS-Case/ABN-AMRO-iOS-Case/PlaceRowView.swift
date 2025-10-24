//
//  PlaceRowView.swift
//  ABN-AMRO-iOS-Case
//
//  Created by Onur Kara on 24/10/2025.
//

import SwiftUI

struct PlaceRowView: View {

    let place: PlaceViewData

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(place.name)
                .font(.headline)
            Text(place.coordinates)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}
