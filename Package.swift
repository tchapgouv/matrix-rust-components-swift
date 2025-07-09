// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
let checksum = "a89531e4848bcace8dd7e2ec900f5c150b62c471f878acbbfc622c27e5ae3a5b"
let version = "25.04.30-bwi-0-8-1"
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
