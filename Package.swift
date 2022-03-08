// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Down",
    platforms: [
        .macOS("10.15"),
        .iOS("13.0"),
        .tvOS("13.0")
    ],
    products: [
        .library(
            name: "Down",
            targets: ["Down"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.9.0"
        ),
    ],
    targets: [
        .target(
            name: "libcmark",
            dependencies: [],
            path: "Sources/cmark",
            exclude: [
                "include",
                "case_fold_switch.inc",
                "entities.inc",
                "COPYING"
            ],
            publicHeadersPath: "./"
        ),
        .target(
            name: "Down",
            dependencies: ["libcmark"],
            path: "Sources/Down",
            exclude: ["Down.h"],
            resources: [
                .copy("Resources/DownView.bundle"),
                .copy("Resources/DownView (macOS).bundle"),
            ]
        ),
        .testTarget(
            name: "DownTests",
            dependencies: [
                "Down",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            path: "Tests/DownTests",
            exclude: [
                "AST/__Snapshots__",
                "Fixtures",
                "Styler/__Snapshots__",
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
