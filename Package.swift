// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
let checksum = "4d9e2e5c7c3c3d3ad388bde082700cb72a3b86f1ba7c12ea8f88b8d3a760006d"
let version = "26.06.0-remove-only-bwi"
let url = "https://github.com/tchapgouv/matrix-rust-components-swift/releases/download/\(version)/MatrixSDKFFI.xcframework.zip"
let package = Package(
    name: "MatrixRustSDK",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "MatrixRustSDK", type: .dynamic, targets: ["MatrixRustSDK"]),
    ],
    targets: [
//        .binaryTarget(name: "MatrixSDKFFI", path: "MatrixSDKFFI.xcframework.zip"),
// Comment next line and uncomment previous line to compile against local version of `matrix-rust-sdk`.
        .binaryTarget(name: "MatrixSDKFFI", url: url, checksum: checksum),
        .target(name: "MatrixRustSDK", dependencies: [.target(name: "MatrixSDKFFI")])
    ]
)
