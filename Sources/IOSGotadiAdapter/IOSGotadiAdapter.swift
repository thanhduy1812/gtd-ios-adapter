import Flutter
public struct IOSGotadiAdapter {
    public private(set) var text = "Hello, World!"
     
    var flutterEngine = FlutterEngine(name: "my flutter engine")
    class Bar {}
    static var demoBundle: Bundle { return Bundle(for: IOSGotadiAdapter.Bar.self) }
    public init() {
        self.flutterEngine.run()
        let methodChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery", binaryMessenger: self.flutterEngine.binaryMessenger)
        methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            // Handle incoming messages from Flutter
            if (call.method == "getBatteryLevel") {
              // Handle the message and return a result
              print("battery")
    //          result(Int(returnValue))
            } else {
              result(FlutterMethodNotImplemented)
            }
        }
    }
    
    public func flutterRun() {
        self.flutterEngine.run()
    }
    
    public func showFlutterHome(viewController: UIViewController) {
//        flutterRun()
        let flutterViewController = FlutterViewController(engine: self.flutterEngine, nibName: nil, bundle: Bundle.module)
        viewController.present(flutterViewController, animated: true, completion: nil)
    }
    
    public func showDemoController(viewController: UIViewController, appDelegate: UIApplicationDelegate) {
        let demoVC = DemoViewController(nibName: "DemoViewController", bundle: Bundle.module)
        viewController.present(demoVC, animated: true)
    }
}
