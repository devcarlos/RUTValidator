// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChileanRutUtils",
    products: [
        .library(
            name: "ChileanRutUtils",
            targets: ["ChileanRutUtils"]),
    ],
    targets: [
        .target(
            name: "ChileanRutUtils",
            dependencies: []),
        .testTarget(
            name: "ChileanRutUtilsTests",
            dependencies: ["ChileanRutUtils"]),
    ]
)
