// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "model2vec",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Model2Vec",
            targets: ["Model2Vec"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Model2Vec",
            dependencies: ["model2vecNativeLibs"]
        ),
        .binaryTarget(
            name: "model2vecNativeLibs",
            url: "https://github.com/shubham0204/model2vec.swift/releases/download/v1/model2vec.xcframework.zip",
            checksum: "82de8728993cc47c4a05dc3c47571391299ce4c619263f5895f90b41c4d25104"
        ),
        .testTarget(
            name: "model2vecTests",
            dependencies: ["model2vecSwiftWrapper"]
        ),
    ]
)
