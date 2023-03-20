//
//  GotadiSearchBookViewController.swift
//  
//
//  Created by Duy Nguyen on 01/03/2023.
//

import UIKit
import Flutter
class GotadiSearchBookViewController: FlutterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("flutter didload")
        
//        self.pushRoute("/flightSearch")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view appear")
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("flutter disappear")
//        self.engine?.destroyContext()
//        self.engine?.viewController = nil
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.engine?.viewController = nil
    }
    
    
    deinit {
        print("flutter deinit")
        
    }
    

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
