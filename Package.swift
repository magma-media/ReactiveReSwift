// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "ReactiveReSwift",
  platforms: [
    .iOS(.v8),
  ],
  products: [
    .library(name: "ReactiveReSwift", targets: ["ReactiveReSwift"]),
  ],
  targets: [
    .target(name: "ReactiveReSwift", path: "Sources"),
  ]
)
