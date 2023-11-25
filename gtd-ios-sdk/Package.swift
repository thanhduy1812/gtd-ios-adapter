// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IOSGotadiSDK",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "IOSGotadiSDK",
            targets: ["IOSGotadiSDK", "App", "Flutter", "FlutterPluginRegistrant", "SharedPreferences", "UrlLauncherIOS", "PathProvider"]),
//            targets: ["IOSGotadiAdapter", "App", "Flutter", "audio_session", "FMDB", "just_audio", "path_provider_foundation", "shared_preferences_foundation", "url_launcher_ios", "video_player_avfoundation", "wakelock", "webview_fluttegor_wkwebview"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "IOSGotadiSDK",
            dependencies: []),
        .binaryTarget(name: "App", path: "App.xcframework"),
        .binaryTarget(name: "Flutter", path: "Flutter.xcframework"),
        .binaryTarget(name: "FlutterPluginRegistrant", path: "FlutterPluginRegistrant.xcframework"),
//        .binaryTarget(name: "audio_session", path: "audio_session.xcframework"),
//        .binaryTarget(name: "FMDB", path: "FMDB.xcframework"),
//        .binaryTarget(name: "just_audio", path: "just_audio.xcframework"),
        .binaryTarget(name: "PathProvider", path: "path_provider_foundation.xcframework"),
        .binaryTarget(name: "SharedPreferences", path: "shared_preferences_foundation.xcframework"),
        .binaryTarget(name: "UrlLauncherIOS", path: "url_launcher_ios.xcframework"),
//        .binaryTarget(name: "video_player_avfoundation", path: "video_player_avfoundation.xcframework"),
//        .binaryTarget(name: "wakelock", path: "wakelock.xcframework"),
//        .binaryTarget(name: "webview_flutter_wkwebview", path: "webview_flutter_wkwebview.xcframework")
    ]
)