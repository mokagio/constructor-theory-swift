// swift-tools-version: 6.3

import PackageDescription

let package = Package(
  name: "ConstructorTheory",
  products: [
    .library(name: "ConstructorTheory", targets: ["ConstructorTheory"])
  ],
  targets: [
    .target(name: "ConstructorTheory"),
    .testTarget(name: "ConstructorTheoryTests", dependencies: ["ConstructorTheory"]),
  ],
  swiftLanguageModes: [.v6]
)
