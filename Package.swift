// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CapturePreventionKit",
  platforms: [
    .iOS(.v13),
    .tvOS(.v13)
  ],
  products: [
    .library(
      name: "CapturePreventionKit",
      targets: ["CapturePreventionKit"])
  ],
  targets: [
    .target(
      name: "CapturePreventionKit",
      dependencies: []),
    .testTarget(
      name: "CapturePreventionKitTests",
      dependencies: ["CapturePreventionKit"])
  ]
)
