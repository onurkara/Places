//
//  Place.swift
//  DataProvider
//
//  Created by Onur Kara on 24/10/2025.
//

public struct Place: Decodable {

    public let name: String?
    public let latitude: Double?
    public let longitude: Double?

    public init(name: String?, latitude: Double?, longitude: Double?) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
}


