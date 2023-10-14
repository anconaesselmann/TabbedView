// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TabbedView",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "TabbedView",
            targets: ["TabbedView"]),
    ],
    targets: [
        .target(
            name: "TabbedView"),
    ]
)
