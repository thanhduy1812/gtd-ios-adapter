//
//  File.swift
//  
//
//  Created by Duy Nguyen on 26/02/2023.
//

import Foundation
import UIKit
import Flutter

public class GotadiPackagePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "samples.flutter.dev/battery", binaryMessenger: registrar.messenger())
        let instance = GotadiPackagePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "getBatteryLevel") {
          // Handle the message and return a result
          print("battery")
//          result(Int(returnValue))
        } else {
          result(FlutterMethodNotImplemented)
        }
    }
}
