// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-creative",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Creative",
            targets: ["Creative"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Creative",
            exclude: ["Math/Vector.swift.gyb", "Math/Point.swift.gyb"]),
        .testTarget(
            name: "CreativeTests",
            dependencies: ["Creative"],
            exclude: ["VectorTests.swift.gyb", "PointTests.swift.gyb"]
        ),
    ]
)
