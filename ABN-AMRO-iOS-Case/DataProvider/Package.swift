// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataProvider",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "PlacesDataProvider",
            targets: ["PlacesDataProvider"]),
    ],
    dependencies: [
        .package(path: "../Network")
    ],
    targets: [
        .target(
            name: "PlacesDataProvider",
            dependencies: ["Network"],
            path: "Sources/PlacesDataProvider"
        ),
        .testTarget(
            name: "PlacesDataProviderTests",
            dependencies: ["PlacesDataProvider", "Network"]
        ),
    ]
)
