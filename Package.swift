// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "swift-creative",
    products: [
        .library(
            name: "Creative",
            targets: ["Creative"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Creative",
            dependencies: [.product(name: "RealModule", package: "swift-numerics")],
            exclude: ["Math/Vector.swift.gyb", "Math/Point.swift.gyb", "Math/Size.swift.gyb", "Math/Matrix.swift.gyb"]),
        .testTarget(
            name: "CreativeTests",
            dependencies: ["Creative", .product(name: "RealModule", package: "swift-numerics")],
            exclude: ["VectorTests.swift.gyb", "PointTests.swift.gyb", "SizeTests.swift.gyb", "MatrixTests.swift.gyb"]
        ),
    ]
)
