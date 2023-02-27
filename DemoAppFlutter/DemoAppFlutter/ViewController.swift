//
//  ViewController.swift
//  DemoAppFlutter
//
//  Created by Duy Nguyen on 24/02/2023.
//

import UIKit
import DemoPackageAdapter


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func pressButton(_ sender: Any) {
//        let text = DemoPackageAdapter().text
//        print(text)
        let object = DemoPackageAdapter()
//        object.flutterRun()
//        print(object.text)
        object.showFlutterHome(viewController: self)
//        object.showDemoController(viewController: self)
    }
    
}

