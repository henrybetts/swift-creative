// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "swift-creative",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "Creative",
            targets: ["Creative"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
    ],
    targets: [
        .systemLibrary(
            name: "CGLFW",
            pkgConfig: "glfw3",
            providers: [
                .brew(["glfw"])]),
        .target(
            name: "Creative",
            dependencies: ["CGLFW", .product(name: "RealModule", package: "swift-numerics")],
            exclude: ["Math/Vector.swift.gyb", "Math/Point.swift.gyb", "Math/Size.swift.gyb", "Math/Matrix.swift.gyb"]),
        .executableTarget(
            name: "WindowDemo",
            dependencies: ["Creative"],
            path: "Examples/WindowDemo"),
        .testTarget(
            name: "CreativeTests",
            dependencies: ["Creative", .product(name: "RealModule", package: "swift-numerics")],
            exclude: ["VectorTests.swift.gyb", "PointTests.swift.gyb", "SizeTests.swift.gyb", "MatrixTests.swift.gyb"]
        ),
    ]
)
