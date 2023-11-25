//
//  ViewController.swift
//  TestPacakgeGit
//
//  Created by Duy Nguyen on 27/02/2023.
//

import UIKit
import IOSGotadiSDK
class ViewController: UIViewController {
    let object: IOSGotadiSDK = IOSGotadiSDK.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TODO: Call API authorize get Token from Gotadi
        object.setup(partnerSetting:
                        GotadiPartnerSetting(
                            env: "uat",
                            partnername: "vib",
                            language: "vi", token: "token", theme:.secondary))

    }

    @IBAction func actionFlutter(_ sender: Any) {
//        let object = IOSGotadiAdapter()
        object.pushToHomePartner(partnerViewController: self, handlePayment: {[weak self] gotadiViewController, bookingNumber in
            print(bookingNumber)
            if let paymentViewController  = self?.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
                paymentViewController.bookingNumberResult = bookingNumber
                gotadiViewController.navigationController?.pushViewController(paymentViewController, animated: true)
            }
        })


//        object.showDemoController(viewController: self)
    }
    @IBAction func showBookingDetail(_ sender: Any) {
//        object?.showBookingDetail(viewController: self)
        object.pushToMyBooking(viewController: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    @IBAction func onChangeTheme(_ sender: UISwitch) {
        
        if sender.isOn {
            object.config?.changeTheme(theme: .primary)
        } else {
            object.config?.changeTheme(theme: .secondary)
        }
        
    }
    
    
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count == 2
    }
}
