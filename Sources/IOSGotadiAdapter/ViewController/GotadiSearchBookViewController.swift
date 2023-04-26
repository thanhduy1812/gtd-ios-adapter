//
//  GotadiSearchBookViewController.swift
//  
//
//  Created by Duy Nguyen on 01/03/2023.
//

import UIKit
import Flutter
class GotadiSearchBookViewController: FlutterViewController {
    var isPushToMyBooking: Bool?
    var isPushToInvoice: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("GotadiSearchBookViewController didload")
        
//        self.pushRoute("/flightSearch")
        // Do any additional setup after loading the view.
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("GotadiSearchBookViewController appear")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("GotadiSearchBookViewController didappear")
        if(isPushToMyBooking ?? false) {
            isPushToMyBooking = false
            self.pushRoute("/myBooking")
        }
        if (isPushToInvoice ?? false) {
            isPushToInvoice = false
            self.pushRoute("/vibInvoice")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("GotadiSearchBookViewController disappear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        print("GotadiSearchBookViewController deinit")
        
    }
    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        print("GotadiSearchBookViewController init")
//    }
//
//    override init(engine: FlutterEngine, nibName: String?, bundle nibBundle: Bundle?) {
//        super.init(engine: engine, nibName: nibName, bundle: nibBundle)
//        print("GotadiSearchBookViewController init with engine")
//    }
//
//    override init(project: FlutterDartProject?, initialRoute: String?, nibName: String?, bundle nibBundle: Bundle?) {
//        super.init(project: project, initialRoute: initialRoute, nibName: nibName, bundle: nibBundle)
//        print("GotadiSearchBookViewController init with project")
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension UINavigationController: UIGestureRecognizerDelegate {
//    override open func viewDidLoad() {
//        super.viewDidLoad()
//        interactivePopGestureRecognizer?.delegate = self
//    }
//
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return viewControllers.count == 2
//    }
//}
