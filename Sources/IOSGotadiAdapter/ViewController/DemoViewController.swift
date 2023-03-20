//
//  DemoViewController.swift
//  
//
//  Created by Duy Nguyen on 24/02/2023.
//

import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func pressDemo(_ sender: Any) {
        print("Demo controller")
    }
    
    deinit {
        print("demoviewDeinit")
    }
    
}
