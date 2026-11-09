// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iqchannels",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "iqchannels", targets: ["iqchannels"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/iqstore/iqchannels-swift.git", exact: "2.2.2"),
        // iqchannels-swift supports iOS 14 but takes SQLite.swift without an upper bound; 0.17.0+ requires iOS 15.
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", "0.13.0"..<"0.17.0")
    ],
    targets: [
        .target(
            name: "iqchannels",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "IQChannelsSwift", package: "iqchannels-swift"),
                .product(name: "SQLite", package: "SQLite.swift")
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
