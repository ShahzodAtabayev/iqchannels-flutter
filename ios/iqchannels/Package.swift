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
        .package(url: "https://github.com/iqstore/iqchannels-swift.git", exact: "2.2.2")
    ],
    targets: [
        .target(
            name: "iqchannels",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "IQChannelsSwift", package: "iqchannels-swift")
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
