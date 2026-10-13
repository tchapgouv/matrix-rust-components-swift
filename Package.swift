// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
let checksum = "0c12b4bd2220d3e4ac4c48197bf6bfeed3cc0deba5aef8b646754def5dd5e5ff"
let version = "26.09.2-main-ios"
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
