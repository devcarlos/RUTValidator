// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RUTValidator",
    products: [
        .library(
            name: "RUTValidator",
            targets: ["RUTValidator"]),
    ],
    targets: [
        .target(
            name: "RUTValidator",
            dependencies: []),
        .testTarget(
            name: "RUTValidatorTests",
            dependencies: ["RUTValidator"]),
    ]
)
