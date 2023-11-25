import Flutter
import FlutterPluginRegistrant
public class IOSGotadiSDK {
    
    public static let shared = IOSGotadiSDK()
    
    var flutterEngine: FlutterEngine?
    var methodChannel: FlutterMethodChannel? = nil
    class ReferBundle {}
    static var referBundle: Bundle { return Bundle(for: IOSGotadiSDK.ReferBundle.self) }
    
    public var config: GotadiPartnerSetting?
    
    private init() {
        self.flutterEngine = FlutterEngine(name: "GotadiSDK")
//        currentFlutterViewController = GotadiSearchBookViewController(project: FlutterDartProject(precompiledDartBundle: Bundle.module), initialRoute: "/homeVIB", nibName: nil, bundle: Bundle.module)
//        print(getDocumentsDirectory())
    }
    
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
    
    public func setup(partnerSetting: GotadiPartnerSetting) {
        config = partnerSetting
        self.flutterEngine?.run(withEntrypoint: "", initialRoute: "/homeVIB")
        GeneratedPluginRegistrant.register(with: self.flutterEngine!)
        self.flutterEngine?.localizationChannel?.setMethodCallHandler({ call, result in
            if call.method == "partner.app.scheme" {
                let data: [String: String] = [
                    "env": partnerSetting.env,
                    "partner": partnerSetting.partnername,
                    "locale" : partnerSetting.language,
                    "token" : partnerSetting.token,
                    "theme" : partnerSetting.theme.rawValue,
                ]
                result(data)
            }
        })
    }
    
    public func flutterRun() {
        self.flutterEngine?.run()
//        self.flutterEngine.run(withEntrypoint: "", initialRoute: "/flightSearch")
    }
    
    public func pushToHomePartner(partnerViewController: UIViewController, showBottomBar: Bool? = false, handlePayment:@escaping (_ gotadiViewController: UIViewController, _ bookingNumber: String) -> Void) {
        guard let flutterEngine = self.flutterEngine else {return}
        guard let _ = partnerViewController.navigationController else {
            fatalError("Your viewcontroller must have navigation stack")
        }
        flutterEngine.viewController = nil
        let homeBookingVC = GotadiSearchBookViewController(engine: flutterEngine, nibName: nil, bundle: Bundle.module)
        homeBookingVC.engine?.navigationChannel.setMethodCallHandler({[weak self] call, result in
            if call.method == "push.partner.payment" {
                print("push to payment viewcontroller")
                let bookingNumber = call.arguments as? String
                handlePayment(homeBookingVC, bookingNumber ?? "unknown booking")
                result(true)
            } else if call.method == "pop.partner.home" {
                self?.popToHomePartner()
                result(true)
            }
        })
        if showBottomBar == false {
            _ = partnerViewController.navigationController?.hidesBottomBarWhenPushed
        }
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
