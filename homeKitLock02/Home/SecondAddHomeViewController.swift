//
//  SecondAddHomeViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 17/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class SecondAddHomeViewController: UIViewController {

    @IBOutlet weak var homeNameTextField: UITextField!
    
    let homeManager = HMHomeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func addHomeBtn(_ sender: Any) {
        homeManager.addHome(withName: self.homeNameTextField.text!) { (home, error) in
            if error != nil{
                print(error)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
