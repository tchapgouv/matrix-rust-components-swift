# Matrix Rust SDK for Apple Tchap fork

## Prerequistes

- Install rust and cargo (https://www.rust-lang.org/tools/install)
- Add any dependencies required to build the matrix-rsut-sdk and bindings for Apple platforms as specified [here](https://github.com/matrix-org/matrix-rust-sdk/blob/main/bindings/apple/README.md).


- Clone https://github.com/element-hq/matrix-rust-components-swift in `matrix-rust-sdk-tchap` folder.
- Clone **your fork** of https://github.com/matrix-org/matrix-rust-sdk in `matrix-rust-sdk-tchap` folder
as specified in [README](https://github.com/element-hq/matrix-rust-components-swift/blob/main/Tools/Release/README.md).

- Your `matrix-rust-sdk-tchap` should now contains 2 subfolders:
  - matrix-rust-components-swift
  - matrix-rust-sdk
  
- Set api.github.com in your .netrc file before using cargo + rustup

- Checkout the main branch of the SDK (or another custom branch to release from).

## Build the Swift package

- cd to the build script folder: `cd <local dir>/matrix-rust-sdk-tchap/matrix-rust-components-swift/Tools/Release/Sources`
- launch the build: `swift run release --version 20250115a --local-only`

- This will generate 2 files:
  - the **xcframework structure** (zipped, ready to be embedded into SwiftPackage) located at `<local dir>/matrix-rust-sdk-tchap/matrix-rust-components-swift/MatrixSDKFFI.xcframework.zip`
  - the **SwiftPackage manifest** located at `<local dir>/matrix-rust-sdk-tchap/matrix-rust-components-swift/Package.swift`
    - this manifest lists the version just generated and the correct checksum
    - But we will use it as a local binary target. The `url` property in `targets` is replaced by local `path` property and `checksum` property is removed (unused when using local dependency).
  - Note: the file `Package.swift` will be updated if present.

If the file `Package.swift` already exists in `matrix-rust-components-swift` folder, it will be updated with generated version. The `Package.swift` file template can be as follow (prefilled for a locally generated Swift Package framework):
```
import PackageDescription

let checksum = "2a88812359540daa939308cf8380eb0b2b48f34be5665f0f731f8a55dbbc630c"
let version = "20250115a"
let localpath = "MatrixSDKFFI.xcframework.zip"

let package = Package(
    name: "MatrixRustSDK",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "MatrixRustSDK", type: .dynamic, targets: ["MatrixRustSDK"]),
    ],
    targets: [
        .binaryTarget(name: "MatrixSDKFFI", path: localpath),
        .target(name: "MatrixRustSDK", dependencies: [.target(name: "MatrixSDKFFI")])
    ]
)
```

## Use the local Swift package in Tchap project

The `project.yml` file (referenced by `project-tchap-x.yml` file) must now reference the local SwiftPackage in the `packages` section:
```
packages:
  # Element/Matrix dependencies
  MatrixRustSDK:
    # url: https://github.com/element-hq/matrix-rust-components-swift
    # exactVersion: 1.0.77
    path: ../matrix-rust-sdk-tchap/matrix-rust-components-swift
```

Note: the locally linked `matrix-rust-components-swift` package is not in Xcode `Package Dependencies` section of the project but in `Packages` folder of the project source tree.

## Caveat

If generated Mocks/SDK are not up-to-date (becasue checked-out branches in `TchapX/ElementX` and `matrix-rust-sdk` are not synced), you can regenerate mocks:
  - for **GeneratedMocks.swift**: `sourcery --config Tools/Sourcery/AutoMockableConfig.yml`
  - for **SDKGeneratedMocks.swift** : `sourcery --sources ../matrix-rust-sdk-tchap/matrix-rust-components-swift/Sources/MatrixRustSDK/matrix_sdk_ffi.swift --templates Tools/Sourcery/SDKAutoMockable.stencil --output ElementX/Sources/Mocks/Generated/SDKGeneratedMocks.swift`
  
  