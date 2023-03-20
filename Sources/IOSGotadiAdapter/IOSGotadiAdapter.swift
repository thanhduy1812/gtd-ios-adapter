import Flutter
public class IOSGotadiAdapter {
    public private(set) var text = "Hello, World!"
     
    var flutterEngine = FlutterEngine(name: "GotadiSDK")
    var methodChannel: FlutterMethodChannel? = nil
    class Bar {}
    static var demoBundle: Bundle { return Bundle(for: IOSGotadiAdapter.Bar.self) }
    public init() {
        self.flutterEngine.run()

//        self.flutterEngine.run(withEntrypoint: "", initialRoute: "/flightSearch")


        
//        sendMessageToFlutter()
//        sendMessageFromFlutter()
    }
    
//    private func sendMessageToFlutter(){
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {[weak self] in
//            self?.methodChannel?.invokeMethod("getAppConfig", arguments: ["locale": "en"])
//        }
//    }
    
    private func sendMessageFromFlutter() {
        let methodChannel = FlutterMethodChannel(name: "com.gotadi.dev/config", binaryMessenger: self.flutterEngine.binaryMessenger)
        methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            // Handle incoming messages from Flutter
            if (call.method == "getBatteryLevel") {
              // Handle the message and return a result
              print("battery")
    //          result(Int(returnValue))
            } else if (call.method == "getLocale") {
                result(2)
            } else if (call.method == "getAppConfig") {
                result("en")
            }
            else {
              result(FlutterMethodNotImplemented)
            }
        }
    }
    
    public func flutterRun() {
        self.flutterEngine.run()
//        self.flutterEngine.run(withEntrypoint: "", initialRoute: "/flightSearch")
    }
    
    public func showFlutterHome(viewController: UIViewController) {
//        flutterRun()
//        sendMessageToFlutter()
//        sendMessageToFlutter()
//        self.flutterEngine.navigationChannel.invokeMethod(<#T##method: String##String#>, arguments: <#T##Any?#>)
        
//        let flutterViewController = FlutterViewController(engine: self.flutterEngine, nibName: nil, bundle: Bundle.module)
//        self.flutterEngine.run(withEntrypoint: "/b2b2cMain", initialRoute: "/flightSearch")
//        self.flutterEngine.run(withEntrypoint: "SearchFlightPage")
    
        self.flutterEngine.viewController = nil
//        self.flutterEngine.restorationChannel
//        self.flutterEngine.run(withEntrypoint: "", initialRoute: "/flightSearch")
        let flutterViewController = GotadiSearchBookViewController(engine: self.flutterEngine, nibName: nil, bundle: Bundle.module)
//        flutterViewController.navigationController?.setNavigationBarHidden(true, animated: true)
        if let nav = viewController.navigationController {
            nav.pushViewController(flutterViewController, animated: true)
        } else {
            viewController.present(flutterViewController, animated: true)
        }
//        viewController.present(flutterViewController, animated: true, completion: nil)
    }
    
    deinit {
        print("deninit gotadi adapter")
    }
    
    public func showDemoController(viewController: UIViewController) {
        let demoVC = DemoViewController(nibName: "DemoViewController", bundle: Bundle.module)
        if let nav = viewController.navigationController {
            nav.pushViewController(demoVC, animated: true)
        } else {
            viewController.present(demoVC, animated: true)
        }
//        viewController.navigationController?.pushViewController(demoVC, animated: true)

    }
}
