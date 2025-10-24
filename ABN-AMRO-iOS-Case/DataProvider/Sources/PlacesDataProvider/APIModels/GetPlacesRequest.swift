//
//  GetPlacesRequest.swift
//  DataProvider
//
//  Created by Onur Kara on 24/10/2025.
//

import Network

struct GetPlacesRequest: BaseRequest {

    var path: String = "main/locations.json"
    var method: Network.HTTPMethod = .get
}
