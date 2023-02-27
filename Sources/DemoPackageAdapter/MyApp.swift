//
//  File.swift
//  
//
//  Created by Duy Nguyen on 24/02/2023.
//

//import Foundation
//import SwiftUI
//import Flutter
//
//class FlutterDependencies: ObservableObject {
//  let flutterEngine = FlutterEngine(name: "my flutter engine")
//  init(){
//    // Runs the default Dart entrypoint with a default Flutter route.
//    flutterEngine.run()
//    // Connects plugins with iOS platform code to this app.
//  }
//}
//
//@main
//struct MyApp: App {
//  // flutterDependencies will be injected using EnvironmentObject.
//  @StateObject var flutterDependencies = FlutterDependencies()
//    var body: some Scene {
//      WindowGroup {
//        ContentView().environmentObject(flutterDependencies)
//      }
//    }
//}
import UIKit
import Flutter
// The following library connects plugins with iOS platform code to this app.
//import FlutterPluginRegistrant

//@UIApplicationMain
//class AppDelegate: FlutterAppDelegate { // More on the FlutterAppDelegate.
//  lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
//
//  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//    // Runs the default Dart entrypoint with a default Flutter route.
//    flutterEngine.run();
//    // Connects plugins with iOS platform code to this app.
////    GeneratedPluginRegistrant.register(with: self.flutterEngine);
//    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
//  }
//}
