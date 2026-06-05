// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
let checksum = "12618aad50bdc57ad21387504ea1041c8224804a421328ba2eac6f37d7752431"
let version = "26.05.3-bwi-main"
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
