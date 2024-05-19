// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Todo",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TodoList",
            targets: ["TodoList"]),
        .library(
            name: "TodoDetail",
            targets: ["TodoDetail"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.10.4"),
        .package(path: "../Model"),
        .package(path: "../Client"),
        .package(path: "../UIComponent"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TodoList",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "Model",
                "Client",
                "UIComponent",
                "TodoDetail",
            ]
        ),
        .target(
            name: "TodoDetail",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "Model",
                "Client",
                "UIComponent",
            ]
        )
    ]
)
