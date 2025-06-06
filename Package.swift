// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "model2vec",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Model2Vec",
            targets: ["model2vec"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "model2vec",
            dependencies: ["model2vecNativeLibs"]
        ),
        .binaryTarget(
            name: "model2vecNativeLibs",
            url: "https://github.com/shubham0204/model2vec.swift/releases/download/v1/model2vec.xcframework.zip",
            checksum: "d77bd9c65d857a6fe59606c897355d2dd3bc5383a372417c99bc4c47ee2f567f"
        ),
        .testTarget(
            name: "model2vecTests",
            dependencies: ["model2vec"]
        ),
    ]
)
