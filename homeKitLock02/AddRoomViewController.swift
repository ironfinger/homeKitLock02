//
//  AddRoomViewController.swift
//  homeKitLock02
//
//  Created by Thomas Houghton on 17/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class AddRoomViewController: UIViewController {

    @IBOutlet weak var roomNameTextField: UITextField!
    
    let homeManager = HMHomeManager()
    var chosenHomeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addRoomTapped(_ sender: Any) {
        homeManager.homes[chosenHomeIndex].addRoom(withName: roomNameTextField.text!) { (room, error) in
            if error != nil {
                print(error)
            }else{
                self.navigationController?.popViewController(animated: true)
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
