//
//  GetPlacesResponse.swift
//  DataProvider
//
//  Created by Onur Kara on 24/10/2025.
//

public struct GetPlacesResponse: Decodable {

    public let places: [Place]
    
    enum CodingKeys: String, CodingKey {
        case places = "locations"
    }
}
