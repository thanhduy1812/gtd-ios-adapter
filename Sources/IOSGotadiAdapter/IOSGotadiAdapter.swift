import Flutter
public class IOSGotadiAdapter {
    public private(set) var text = "Hello, World!"
    
    public static let shared = IOSGotadiAdapter()
    
    var flutterEngine: FlutterEngine?
    var methodChannel: FlutterMethodChannel? = nil
    var gotadiViewController: GotadiSearchBookViewController?
    class Bar {}
    static var demoBundle: Bundle { return Bundle(for: IOSGotadiAdapter.Bar.self) }
    
    private init() {
//        self.flutterEngine.run(withEntrypoint: "", initialRoute: "/homeVIB")
//        DispatchQueue.main.async {[weak self] in
//            self?.flutterEngine = FlutterEngine(name: "GotadiSDK")
//            self?.flutterEngine?.run()
//        }
        self.flutterEngine = FlutterEngine(name: "GotadiSDK")
        self.flutterEngine?.run(withEntrypoint: "", initialRoute: "/homeVIB")
//        currentFlutterViewController = GotadiSearchBookViewController(project: FlutterDartProject(precompiledDartBundle: Bundle.module), initialRoute: "/homeVIB", nibName: nil, bundle: Bundle.module)
        print(getDocumentsDirectory())


//        self.flutterEngine.run(withEntrypoint: "", initialRoute: "/flightSearch")


        
//        sendMessageToFlutter()
//        sendMessageFromFlutter()
        
        //Handle pushtoPayment
//        self.flutterEngine?.navigationChannel.setMethodCallHandler({[weak self] call, result in
//            if call.method == "partner.payment" {
//                print("push to payment viewcontroller")
//                if let payVC = self?.paymentViewController {
//                    self?.flutterEngine?.viewController?.navigationController?.pushViewController(payVC, animated: true)
//                }
//            }
//        })
    }
    
//    private func sendMessageToFlutter(){
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {[weak self] in
//            self?.methodChannel?.invokeMethod("getAppConfig", arguments: ["locale": "en"])
//        }
//    }
    
    private func sendMessageFromFlutter() {
        guard let flutterEngine = self.flutterEngine else {return}
        let methodChannel = FlutterMethodChannel(name: "com.gotadi.dev/config", binaryMessenger: flutterEngine.binaryMessenger)
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
        self.flutterEngine?.run()
//        self.flutterEngine.run(withEntrypoint: "", initialRoute: "/flightSearch")
    }
    
    public func showFlutterHome(viewController: UIViewController, paymentViewController: UIViewController) {
//        flutterRun()
//        sendMessageToFlutter()
//        sendMessageToFlutter()
//        self.flutterEngine.navigationChannel.invokeMethod(<#T##method: String##String#>, arguments: <#T##Any?#>)
        
//        let flutterViewController = FlutterViewController(engine: self.flutterEngine, nibName: nil, bundle: Bundle.module)
//        self.flutterEngine.run(withEntrypoint: "/b2b2cMain", initialRoute: "/flightSearch")
//        self.flutterEngine.run(withEntrypoint: "SearchFlightPage")
        guard let flutterEngine = self.flutterEngine else {return}
    
//        flutterEngine.viewController = nil
//        self.flutterEngine.restorationChannel
//        self.flutterEngine.run(withEntrypoint: "", initialRoute: "/flightSearch")
        let flutterViewController = GotadiSearchBookViewController(engine: flutterEngine, nibName: nil, bundle: Bundle.module)
//        flutterViewController.navigationController?.setNavigationBarHidden(true, animated: true)
        if let nav = viewController.navigationController {
            nav.pushViewController(flutterViewController, animated: true)
        } else {
            viewController.present(flutterViewController, animated: true)
        }
//        viewController.present(flutterViewController, animated: true, completion: nil)
    }
    
    public func pushToHomePartner(partnerViewController: UIViewController, handlePayment:@escaping (_ gotadiViewController: UIViewController, _ bookingNumber: String) -> Void) {
        guard let flutterEngine = self.flutterEngine else {return}
        let homeBookingVC = GotadiSearchBookViewController(engine: flutterEngine, nibName: nil, bundle: Bundle.module)
        homeBookingVC.engine?.navigationChannel.setMethodCallHandler({[weak self] call, result in
            if call.method == "push.partner.payment" {
                print("push to payment viewcontroller")
                let bookingNumber = call.arguments as? String
                print(call.arguments)
                handlePayment(homeBookingVC, bookingNumber ?? "unknown booking")
                result(true)
            } else if call.method == "pop.partner.home" {
                self?.popToHomePartner()
                result(true)
            }
        })
        partnerViewController.navigationController?.pushViewController(homeBookingVC, animated: true)

    }
    
    public func pushToFinalBooking(viewController: UIViewController) {
        if let flutterEngine = self.flutterEngine {
//            self.flutterEngine?.viewController = nil
//            self.flutterEngine?.run(withEntrypoint: "", initialRoute: "/myBooking")
            let finalBookingVC = GotadiSearchBookViewController(engine: flutterEngine, nibName: nil, bundle: Bundle.module)
//            let bookingDetailViewController = GotadiSearchBookViewController(project: FlutterDartProject(precompiledDartBundle: Bundle.module), initialRoute: "/homeVIB", nibName: nil, bundle: Bundle.module)

            viewController.navigationController?.pushViewController(finalBookingVC, animated: true)
        }
//        let bookingDetailViewController = GotadiSearchBookViewController(project: FlutterDartProject(precompiledDartBundle: Bundle.module), initialRoute: "/myBooking", nibName: nil, bundle: Bundle.module)
//
//        viewController.navigationController?.pushViewController(bookingDetailViewController, animated: true)
    }
    
    public func popToHomePartner() {
        self.flutterEngine?.viewController?.navigationController?.popToRootViewController(animated: true)
        do {
//            self.flutterEngine?.viewController = nil
//            self.flutterEngine?.destroyContext()
//            self.flutterEngine?.run()
        }

    }
    
    public func pushToInvoice(viewController: UIViewController) {
        guard let flutterEngine = self.flutterEngine else {return}
        if let mybookingController = flutterEngine.viewController {
            mybookingController.pushRoute("/vibInvoice")
            if let homeViewController = viewController.navigationController?.viewControllers.first {
                viewController.navigationController?.viewControllers = [homeViewController, viewController]
                viewController.navigationController?.pushViewController(mybookingController, animated: true)
            }
        }
        
        flutterEngine.navigationChannel.setMethodCallHandler({[weak self] call, result in
            if call.method == "pop.partner.home" {
                self?.popToHomePartner()
                result(true)
            } else if call.method == "" {
                
            }
        })
    }
    
    public func pushToMyBooking(viewController: UIViewController) {
        guard let flutterEngine = self.flutterEngine else {return}
        flutterEngine.run(withEntrypoint: "/myBooking")
        if let flutterViewController = flutterEngine.viewController {
//            flutterViewController.pushRoute("/myBooking")
            viewController.navigationController?.pushViewController(flutterViewController, animated: true)
        } else {
            let mybookingController = GotadiSearchBookViewController(engine: flutterEngine, nibName: nil, bundle: Bundle.module)
            mybookingController.isPushToMyBooking = true
//            mybookingController.pushRoute("/myBooking")
            
            
            mybookingController.setFlutterViewDidRenderCallback {
                print("setFlutterViewDidRenderCallback--------")
//                flutterEngine.navigationChannel.invokeMethod("pushRoute", arguments: "/myBooking")
//                mybookingController.pushRoute("/myBooking")
            }
            viewController.navigationController?.pushViewController(mybookingController, animated: true)
            
            

        }

        flutterEngine.navigationChannel.setMethodCallHandler({[weak self] call, result in
            if call.method == "pop.partner.home" {
                self?.popToHomePartner()
                result(true)
            }
        })
    }
    
    
    public func showBookingDetail(viewController: UIViewController) {
        guard let flutterEngine = self.flutterEngine else {return}
        let flutterViewController = GotadiSearchBookViewController(engine: flutterEngine, nibName: nil, bundle: Bundle.module)
        let bookingDetailViewController = GotadiSearchBookViewController(project: FlutterDartProject(precompiledDartBundle: Bundle.module), initialRoute: "/homeVIB", nibName: nil, bundle: Bundle.module)
//        self.flutterEngine.navigationChannel.invokeMethod("setInitialRoute", arguments: "/myBooking")
//        flutterEngine.navigationChannel
        flutterEngine.run(withEntrypoint: "")
        flutterViewController.pushRoute("/myBooking")
        bookingDetailViewController.pushRoute("/flightSearch")
        flutterViewController.setFlutterViewDidRenderCallback {
            print("render done")
            flutterViewController.pushRoute("/flightSearch")
        }
        flutterViewController.pushRoute("")
        viewController.navigationController?.pushViewController(bookingDetailViewController, animated: true)
        
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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func runContext() {
        self.flutterEngine?.run()
    }
    
    func releaseContext() {
        self.flutterEngine?.viewController = nil
        self.flutterEngine?.destroyContext()
    }
    
    func dispose() {
        self.flutterEngine = nil
    }
}
