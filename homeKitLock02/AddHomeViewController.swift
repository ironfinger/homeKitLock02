//
//  AddHomeViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 15/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class AddHomeViewController: UIViewController {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var homeNameTextField: UITextField!
    @IBOutlet weak var roomNameTextField: UITextField!
    
    let homeManager = HMHomeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subView.layer.cornerRadius = 20
    }

    @IBAction func addHomeBtn(_ sender: Any) {
        homeManager.addHome(withName: homeNameTextField.text!) { (home, error) in
            if error != nil {
                print("We couldn't add a home \(String(describing: error))")
            }else{
                if let newHome = home {
                    newHome.addRoom(withName: self.roomNameTextField.text!, completionHandler: { (room, error) in
                        if error != nil {
                            print("We couldn't create a room: \(String(describing: error))")
                        }else{
                            
                        }
                    })
                    self.homeManager.updatePrimaryHome(newHome, completionHandler: { (error) in
                        if error != nil {
                            print("We couldn't updatePrimaryHome: \(String(describing: error))")
                        }
                    })
                }
            }
            self.dismiss(animated: true, completion: nil)
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
