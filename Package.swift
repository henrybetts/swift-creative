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
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Creative",
            dependencies: [.product(name: "RealModule", package: "swift-numerics")],
            exclude: ["Math/Vector.swift.gyb", "Math/Point.swift.gyb", "Math/Size.swift.gyb"]),
        .testTarget(
            name: "CreativeTests",
            dependencies: ["Creative", .product(name: "RealModule", package: "swift-numerics")],
            exclude: ["VectorTests.swift.gyb", "PointTests.swift.gyb", "SizeTests.swift.gyb"]
        ),
    ]
)
